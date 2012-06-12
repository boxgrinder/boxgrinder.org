---
title: "Attach and mounting devices in AWS EC2"
layout: one-column
---

## Context

In releases prior to 0.10.2, EBS images would speculatively define [ephemeral][] (instance store) device [attachment mappings][], and for both S3 and EBS images an ephemeral disk was auto-mounted at boot time. This behaviour led to some unforseen problems when new EC2 instances with different device mappings were introduced. A [detailed blog post][] of the circumstances and terminology is useful reading.

[ephemeral]: http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/InstanceStorage.html
[detailed blog post]: /blog/2012/04/20/ebs-and-s3-ami-changes/

## s3
As of 0.10.2 no speculative *mounting* of ephemeral devices occurs for S3 appliances (attachment mappings are provided *automatically* by EC2 for S3 images).

## ebs
As of 0.10.2 no speculative *attachment or mounting* of ephemeral devices occurs for EBS appliances.

## Device Attachment
### S3 AMI

With an S3-based AMI a pre-defined device mapping is provided automatically by EC2, you *can* redefine the default layout if you find it unsatisfactory. See the EBS section, but use `-d ami`.

### EBS AMI

Let's say we wish to map `/dev/sdb` and `/dev/sdc` to `ephemeral0`, and `ephemeral1` respectively:
      
    $ boxgrinder-build my.appl -p ec2 -d ebs --delivery-config \
       block-device-mapping:"/dev/sdb=ephemeral0&/dev/sdc=ephemeral1"

> Note the quotation marks, otherwise your shell may gobble the & symbol

### Launch-time
It is possible to configure block device mappings when launching an image rather than baking it, or for cases where you may wish to tweak existing mappings. For instance, using the `ec2-run-instances` [command line tool][]:
   
    ec2-run-instances <ami_id> --block-device-mapping /dev/sdc=ephemeral0

[command line tool]: http://docs.amazonwebservices.com/AWSEC2/latest/CommandLineReference/ApiReference-cmd-RunInstances.html

## Mounting strategies

These apply to both EBS and S3 AMIs.

### Scripts

The most flexible approach is to use a well-maintained script such as **[cloud-init][]** to auto-mount ephemeral devices. Running at boot time, it will locate and mount the ephemeral devices that exist for the particular instance size selected (different instance sizes may have different device mappings).

A cloud-init config file baked into an S3 AMI. Cloud-init now does the hard work for us.

    name: example
    os:
      name: fedora
      version: 16
    packages:
      - cloud-init

You can also use cloud-init to define a custom fstab layout, including settings to avoid boot failure if a device is not present on the given instance size (similar to the custom fstab technique). Looking at their [examples][] is worthwhile.

> With a bit more effort you can get cloud-init running on [RHEL and forks like CentOS/SL](http://www.nimbusproject.org/doc/cloudinitd/1.0/install.html). There are various unofficial sources of cloud-init RPMs for EL that can be [found online](http://pbrady.fedorapeople.org/cloud-init-el6/).

[examples]: http://bazaar.launchpad.net/~cloud-init-dev/cloud-init/trunk/files/head:/doc/examples/

### Custom fstab

A custom fstab could be defined and injected in the post or files section.

    post:
      ec2: 
        - echo '/dev/sdb /media/ephemeral0 ext4 defaults,nobootwait 1 1' >> /etc/fstab

> nobootwait avoids boot failure if the device is not present. It is also possible to insert a custom fstab through the [files][] section.

This strategy can work effectively for EBS AMIs where you explicitly define device names; however, be extremely careful with S3 AMIs where the [predefined][] device names and mappings may surprise you.

[files]: /tutorials/appliance-definition/#files
[predefined]: http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/InstanceStorage.html#InstanceStoreDeviceNames
