---
title: "Upcoming EBS and S3 AMI changes"
author: 'Marc Savy'
layout: blog
timestamp: 2012-04-20t13:30:00.10+01:00
tags: [ boxgrinder_build, aws, ami, ebs, s3 ]
---

In light of some discussions we've been having internally, and with various community members, it has been proposed that as of our next BoxGrinder release, we shall **no longer build images with ephemeral devices<a href="#foot_1">[1]</a> pre-attached (for EBS), or pre-mounted in any fashion<a href="#foot_2">[2]</a> by default (for EBS or S3)<a href="#foot_3">[3]</a>**. 

Instead we will emit a message at build-time about device attachment and mounting, advising users to install a script such as *[cloud-init][]* to auto-mount ephemeral devices, as well as a pointer to a `boxgrinder.org` resource page explaining how best to bake in an appropriate cloud configuration file (more on that soon). 

Those that *want* device mappings baked into their image will continue to be able to do so by defining their desired mappings via configuration. Note that block storage mappings (including ephemeral, or otherwise), can be [configured][] or [reconfigured][] at runtime instead of, or in addition to, build time.

[configured]: http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html#instance-block-device-mapping
[reconfigured]: http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html#BDM_Override

### Providing block device mappings
For EBS AMIs no ephemeral devices are attached by default, whereas with S3 AMIs there is a [default layout][] (although you can modify it as you see fit).

[default layout]: http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/InstanceStorage.html#InstanceStoreDeviceNames

#### At run-time
All of the [standard methods][] of providing (or modifying) a block device mapping at run-time still apply. For example:
    
    ec2-run-instances ami-12345678 -b /dev/xvdb=ephemeral0

#### At build time
You can speculatively map devices that may not be present in every instance size at build time.
    
    # -d ami or -d ebs
    boxgrinder-build my.appl -p ec2 -d ebs --delivery-config \ 
      block_device_mapping:'/dev/xvdb=ephemeral0&/dev/xvdc=ephemeral1'
        
[standard methods]: http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html#instance-block-device-mapping

### Why the changes?

The reasons for this change are multitudinous, but the foremost are:

- **Ephemeral device mappings vary according to instance size**: We cannot make any easy assumptions about which ephemeral disks *will* be present, as it varies depending on which instance size is selected, and is subject to arbitrary change by Amazon.  For instance, recent problems with BoxGrinder S3 AMIs on `m1.small` instances were caused by BoxGrinder assuming a particular ephemeral device would be present; an assumption that fell over when AWS introduced a new device mapping layout<a href="#foot_4">[4]</a>.   

- We do not want to maintain a script that maps and mounts which devices are provided by which instance sizes, as it will **duplicate existing well-established efforts** (e.g. [cloud-init][]), in addition to being difficult to maintain, inferior in functionality, and surprising to the user.  
   
- **Confusion**: Ephemeral device mappings do *not* show on Amazon API queries, or their web UI (!!). Users do not realise a device is attached until they attempt to attach their own device at the same location (e.g. `/dev/xvdb` is an ephemeral device mapping, but it does not show in the web UI; if the user attempts to attach a device at `xvdb` it will fail). 

- **Inconsistency**: BoxGrinder can build a few different OSes, and some of the best cloud initialisation projects are not necessarily available on *all* of the OSes default repositories. We would rather not force disparate solutions onto our users, as consistency is one of our primary goals. 

Therefore we concluded that rather than a prescriptive or inconsistent solution, we shall provide extremely simple default behaviour, and enable the user to choose an approach that is optimal for them.    

### Thoughts?
If you have any objections, comments or suggestions, leave them in the comments, or send them to via any of our [community channels](/community/).

----------

<span id='foot_1'>[1]</span> Ephemeral disks are *transient/instance storage* devices that are available 'free' with most instance sizes. The overall capacity included, and the number of devices the space is subdivided into varies by [instance size][]. For example, a `m1.large` instance has `2x420GiB` instance storage.

<span id='foot_2'>[2]</span> There is an important distinction between *attaching* and *mounting* devices on AWS. Attaching is akin to physically plugging a disk into a machine. Mounting is the usual process of making a device available to the machine's file system. 

<span id='foot_3'>[3]</span> For the sake of clarity, it is worth noting that S3 Backed AMIs always have a pre-defined set of ephemeral device mappings provided by EC2, but with EBS by default there are none.  

<span id='foot_4'>[4]</span> In this particular case we were expecting `/dev/xvdb` to exist, but for `m1.small` the ephemeral device we wanted was mapped to `/dev/xvda2`. 

[cloud-init]: https://help.ubuntu.com/community/CloudInit
[instance size]: http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/InstanceStorage.html
