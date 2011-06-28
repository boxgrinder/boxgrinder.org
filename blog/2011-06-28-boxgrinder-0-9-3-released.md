---
title: "BoxGrinder Build 0.9.3 released"
author: 'Marc Savy'
layout: blog
version: 0.9.3
timestamp: 2011-06-28t18:00:00.10+01:00
tags: [ boxgrinder_build, meta_appliance ]
---

Today marks the release of [BoxGrinder Build](/build/) 0.9.3, packed with important bug fixes and improvements, there are also a few interesting new features to explore.

# BoxGrinder Meta 1.6

The [BoxGrinder Meta appliances](/download/boxgrinder-build-meta-appliance/) provide an automatically-updated and ideally prepared environment to try the latest release of BoxGrinder Build

An [improved release](/download/boxgrinder-build-meta-appliance/) is now available in a variety of virtualized and raw formats, including **BoxGrinder Build EBS AMIs for every AWS region**.  Previously we only published in US East, but in response to demand you can now launch instances in both x86 and i386/i686 versions in all regions. 

The primary improvement in this release, aside from wider global distribution, is the enabling of ntpd to ensure that the system clock remains accurate, avoiding problems when interacting with remote systems that have [sensitivity to time-skew](https://issues.jboss.org/browse/BGBUILD-253). 

# What's new in 0.9.3?

## Scientific Linux support
Through the kind contribution of community member [Neil Wilson (NeilW)](https://github.com/NeilW/), we now have support for Scientific Linux builds. Usage is [quintessentially straightforward](/tutorials/boxgrinder-build-quick-start/build-your-first-appliance/);

    name: my-sl-appliance
    os:
      name: sl
      version: 6

Then run the build: `boxgrinder-build my-sl-appliance.appl`

[Neil's contributed plugin](https://github.com/boxgrinder/boxgrinder-build/blob/b3638120839fb1ccaf319bad6044cef291577f31/lib/boxgrinder-build/plugins/os/sl/sl-plugin.rb) extends the base classes present in BoxGrinder for building RHEL-derived operating systems. For those of you with ambitions to creating additional plugins, this demonstrates how painless it is to extend existing functionality to provide [new features](/tutorials/how-to-write-a-plugin-for-boxgrinder-build/).

## Reliably create and upload EBS backed AMIs in all Amazon AWS regions
Typically a bug-fix doesn't get much prominence in a release announcement, however with the resolution of a ream of interrelated bugs (amongst which included [[BGBUILD-254][]], [[BGBUILD-231][]], [[BGBUILD-251][]], [[BGBUILD-193][]], [[BGBUILD-250][]]), you can now **reliably build and deliver EBS backed AMIs to any Amazon region**. Previously it was only possible to deliver to _us-east-1_ without issues, and even then builds would occasionally fail at random due to concurrency issues, this release fixes those bugs and hence the build process is now far more reliable and reproducible.

    boxgrinder-build my-appliance.appl -p ec2 -d ebs

You must run the build on an instance in the _same_ region that you want the EBS AMI registered in (this is an AWS limitation).  For instance, if you wanted to deliver an appliance to Tokyo (_ap-northeast-1_) then you would need to run your build on an instance running in _ap-northeast-1_.

## Overwrite support for S3, AMIs and EBS AMIs
A common development idiom is to iteratively change an appliance, upload and test it, then tear it down afterwards. However, it is impossible to upload a new iteration with the same name as the previous one, as this is a conflict that AWS rejects.  An obvious work-around is to increment the version and release numbers in your appliance, which will ensure that the generated appliance has a different name to the previous one.  Unfortunately this has the disadvantage that it quickly consumes large volumes of storage (S3, EBS) on Amazon which must be paid for.  Hence to remedy this we have provided an **overwrite** attribute that [can be set](/tutorials/boxgrinder-build-plugins/#Plugin_configuration) for EBS and S3 delivery options, which will cause **the existing version to be torn down, de-registered and deleted**, and the new revision with identical version and release numbers to be uploaded in its place.

In this example, we attempt to upload an [AMI appliance](/tutorials/boxgrinder-build-plugins/#S3_Delivery_Plugin) that is already registered, first without `overwrite` enabled, then subsequently with it:
 
    # First upload
    boxgrinder-build my-appliance.appl -p ec2 -d ami
    # Second upload fails, because there is already an image with the same name, version and release.
    boxgrinder-build my-appliance.appl -p ec2 -d ami
    # Works!
    boxgrinder-build my-appliance.appl -p ec2 -d ami --delivery-config=overwrite:true

Overwrite is supported for AMIs, EBS AMIs, and standard S3 packaged delivery.  EBS overwriting is slightly more complex than the other plugins, as there are several components that work together to make the instance, the most important of which are; a snapshot, an EBS root volume and the registered image.  By setting `overwrite`, the plugin will locate and delete the EBS volume, its associated snapshot, and then de-register the image. If you wish to preserve the snapshot, you must set `preserve_snapshots:true`.

If BoxGrinder appliance [snapshotting](/blog/2011/02/09/boxgrinder-build-0-8-0-released-finally/#Snapshot_support_for_EC2_appliances) is enabled, then only the _very last_ snapshot will be overwritten.

## Plugin configuration is now validated before the build process begins
Previously if bad configuration values were provided to a plugin, the build process would fail only when the plugin was reached in the build pipeline.  BoxGrinder now allows [plugins](/tutorials/boxgrinder-build-plugins/) to **validate before executing the build pipeline**, thus allowing [much earlier detection and failure](/tutorials/how-to-write-a-plugin-for-boxgrinder-build/).  Any plugin developers will need to modify their software to utilise this new feature, a simple example of which is the [SFTP delivery plugin code](https://github.com/boxgrinder/boxgrinder-build/blob/fb5831fa994a096ed5014a766eb9ca2bba133082/lib/boxgrinder-build/plugins/delivery/local/local-plugin.rb), see the `after_init` and `validate` methods.

## Other points of interest
  - BoxGrinder welcomes Japan! Support has been added for _ap-northeast-1_ region for all AWS-related plugins.
  - We have *dropped support for Fedora 13*, as it has reached [EOL status](http://lists.fedoraproject.org/pipermail/announce/2011-June/002979.html).
  - The PAE configuration option is now in the operating system configuration options, rather than the appliance definition, for instance: `... --os-config=pae:false`.
  - `~/.ssh/authorized_keys` no longer fills with duplicate key entries, as a result of our custom `/etc/rc.local` script.
  - The volume of debugging messages emanating from _libguestfs_ has been significantly decreased in `--trace and --debug`.
  
## Comprehensive Change-log  

### Feature Request
 - [[BGBUILD-201][]] Creating a meta-appliance for all the EC2 regions
 - [[BGBUILD-222][]] Allow overwrite of uploaded ec2 image
 - [[BGBUILD-224][]] EBS Plugin Support for CentOS v5.5
 - [[BGBUILD-241][]] Add Scientific Linux support

### Bug

- [[BGBUILD-191][]] Build fails for EC2/EBS appliance when creating filesystem on new disk for CentOS/RHEL 5
- [[BGBUILD-193][]] Amazon EBS delivery plugin: 'Not found device for suffix g' error while building image
- [[BGBUILD-220][]] group names have spaces (to the user), this breaks the schema rules for packages
- [[BGBUILD-223][]] BoxGrinder hangs because qemu.wrapper does not detect x86_64 properly on CentOS 5.6
- [[BGBUILD-229][]] boxgrinder meta fedora 15 not updating itself at boot
- [[BGBUILD-231][]] Cannot register Fedora 15 EC2 AMI with S3 delivery plugin in eu-west-1 availability zone
- [[BGBUILD-232][]] boxgrinder doesn't validate config early enough
- [[BGBUILD-233][]] boxgrinder fails to report a missing config file
- [[BGBUILD-237][]] Tilde characters break creation of yum.conf
- [[BGBUILD-250][]] EBS plugin incorrectly determines that non-US regions are not EC2 instances
- [[BGBUILD-251][]] Add ap-northeast-1 (tokyo) region for EBS plugin
- [[BGBUILD-252][]] rc.local script fills ~/.ssh/authorized_keys with a duplicate key every boot
- [[BGBUILD-253][]] RequestTimeTooSkewed error when attempting upload to S3 from an EC2 instance
- [[BGBUILD-254][]] all EBS volumes are delivered to us-east-1 despite setting other regions and buckets
- [[BGBUILD-260][]] Wrong EC2 discovery causing libguestfs errors on non US regions

### Task

- [[BGBUILD-225][]] Move PAE configuration parameter to operating system configuration

### Enhancement

- [[BGBUILD-261][]] Decrease amount of debug log when downloading or uploading file using guestfs

  [BGBUILD-201]: http://issues.jboss.org/browse/BGBUILD-201
  [BGBUILD-222]: http://issues.jboss.org/browse/BGBUILD-222
  [BGBUILD-224]: http://issues.jboss.org/browse/BGBUILD-224
  [BGBUILD-241]: http://issues.jboss.org/browse/BGBUILD-241
  [BGBUILD-191]: http://issues.jboss.org/browse/BGBUILD-191
  [BGBUILD-193]: http://issues.jboss.org/browse/BGBUILD-193
  [BGBUILD-220]: http://issues.jboss.org/browse/BGBUILD-220
  [BGBUILD-223]: http://issues.jboss.org/browse/BGBUILD-223
  [BGBUILD-229]: http://issues.jboss.org/browse/BGBUILD-229
  [BGBUILD-231]: http://issues.jboss.org/browse/BGBUILD-231
  [BGBUILD-232]: http://issues.jboss.org/browse/BGBUILD-232
  [BGBUILD-233]: http://issues.jboss.org/browse/BGBUILD-233
  [BGBUILD-237]: http://issues.jboss.org/browse/BGBUILD-237
  [BGBUILD-250]: http://issues.jboss.org/browse/BGBUILD-250
  [BGBUILD-251]: http://issues.jboss.org/browse/BGBUILD-251
  [BGBUILD-252]: http://issues.jboss.org/browse/BGBUILD-252
  [BGBUILD-253]: http://issues.jboss.org/browse/BGBUILD-253
  [BGBUILD-254]: http://issues.jboss.org/browse/BGBUILD-254
  [BGBUILD-260]: http://issues.jboss.org/browse/BGBUILD-260
  [BGBUILD-225]: http://issues.jboss.org/browse/BGBUILD-225
  [BGBUILD-261]: http://issues.jboss.org/browse/BGBUILD-261
