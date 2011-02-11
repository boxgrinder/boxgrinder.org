---
title: "BoxGrinder Build 0.8.0 released, finally!"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder, boxgrinder_build, fedora ]
---

I'm
really happy to announce immediate availability of
**BoxGrinder Build 0.8.0**! This is the next major release with
great new features.
# Let's dive into some highlights!

## Consolidated configuration file and command line interface improvements

Both things had quite high priority in my todo list. Both are
drastically improving the usability of BoxGrinder. From now you
don't need to have multiple configuration files -
**everything is located in one file and you can override configuration from command line**.

Configuration file like this:

    plugins:
      vmware:
        type: personal
        thin_disk: true


...and configuration
specified like this:

    boxgrinder build jeos.appl -p vmware --platform-config type:personal thin_disk:true

are **equivalent**! You can use this
to override configuration parameters that you want change sometimes
(for example bucket name when deploying to a test bucket vs.
production bucket).

These changes make
**command line interface much more usable**. For more information
please refer to my
[earlier post](/blog/boxgrinder-build-0-8-0-features-new-configuration-and-cli)
where I explained in detail how to use it.
## Library enhancements

It is now possible to use BoxGrinder Build as a
**library from your Ruby scripts**! I introduced it a bit earlier,
please
[take a look](/blog/boxgrinder-build-0-8-0-features-using-boxgrinder-as-a-library).
## VirtualBox plugin

With 0.8.0 we ship an **early version of VirtualBox plugi**n. What
it creates is really a VMware disk you can import to your library.
In the next versions - we'll extend it to
**generate also metadata files** to directly use BoxGrinder
appliances in VirtualBox.
## Support for all EC2 regions

Yes, it's true, finally. **We support all EC2 regions**. You can
choose now region specifying 'region' config parameter for S3 or
EBS delivery plugins.

If you want register an AMI in us-east-1
region (which is the default region for BG), please use command
similar to this one:

    boxgrinder build jeos.appl -p ec2 -d ami --delivery-config bucket:us-east-1    

To deliver the same appliance to EU bucket:

    boxgrinder build jeos.appl -p ec2 -d ami --delivery-config bucket:eu-west-1

## Snapshot support for EC2 appliances

Imagine you create an appliance for EC2. It starts, you test it but
you're not happy with it. You decide to make some changes but when
you try to register it - you get the message that it's already
registered. Let me introduce **snapshot** feature for delivering
appliances to EC2.

To use snapshots, just specify 'snapshot'
parameter for S3 or EBS plugin, like this:

    boxgrinder build jeos.appl -p ec2 -d ami --delivery-config snapshot:true

## Operating systems support for RHEL 6

Yes, you can now build appliances based on **RHEL 6** for all
currently supported platform/delivery plugins. Enjoy!
## Simpler packages section

We **removed includes section** from packages definition. Consider
this appliance definition snippet:

    packages:
      includes:
        - mc    

This was changed into:

    packages:
      - mc    

To use new BoxGrinder 0.8.0 with appliance
definition files created for earlier versions -
**you need to manually remove the *includes* subsection**.
# Fedora status

Current stable version in Fedora 13 and 14 (and also in Rawhide) is
0.7.1. I'll start submitting version 0.8.0 to Fedora shortly! Stay
tuned. For now - please use
[our repository](http://repo.boxgrinder.org/boxgrinder/boxgrinder.repo).
# Enjoy!

Hope you like the changes. Feel free to reach us in
**\#boxgrinder** channel on irc.freenode.net. Happy building to
you!
# Release notes

## Bug

-   [[BGBUILD-60](https://issues.jboss.org/browse/BGBUILD-60)] -
    Post section merging pattern for appliances depending on the same
    appliance
-   [[BGBUILD-132](https://issues.jboss.org/browse/BGBUILD-132)] -
    Require only region name change for S3 plugin to register AMI in
    different region
-   [[BGBUILD-138](https://issues.jboss.org/browse/BGBUILD-138)] -
    enablerepo path is not escaped when calling repoquery
-   [[BGBUILD-146](https://issues.jboss.org/browse/BGBUILD-146)] -
    BG Build lacks -v --version CLI flags
-   [[BGBUILD-149](https://issues.jboss.org/browse/BGBUILD-149)] -
    Spurious gnome error message during build
-   [[BGBUILD-151](https://issues.jboss.org/browse/BGBUILD-151)] -
    Overriding hardware partitions via inclusion in Appliance
    Definition File causes build failure

## Feature Request

-   [[BGBUILD-68](https://issues.jboss.org/browse/BGBUILD-68)] -
    Global .boxgrinder/config or rc style file for config
-   [[BGBUILD-72](https://issues.jboss.org/browse/BGBUILD-72)] -
    Add support for growing (not pre-allocated) disks for KVM/Xen
-   [[BGBUILD-74](https://issues.jboss.org/browse/BGBUILD-74)] -
    Allow for some way to build and push AMIs to Amazon without bumping
    the version or release numbers in the .appl file
-   [[BGBUILD-75](https://issues.jboss.org/browse/BGBUILD-75)] -
    Allow for some way to build and push EBS-backed AMIs to Amazon
    without bumping the version or release numbers in the .appl file
-   [[BGBUILD-79](https://issues.jboss.org/browse/BGBUILD-79)] -
    Allow to use BoxGrinder Build as a library
-   [[BGBUILD-89](https://issues.jboss.org/browse/BGBUILD-89)] -
    Install @core package group as a minimum package list for RPM-based
    operating systems
-   [[BGBUILD-93](https://issues.jboss.org/browse/BGBUILD-93)] -
    Add Red Hat Enterprise Linux 6 support
-   [[BGBUILD-101](https://issues.jboss.org/browse/BGBUILD-101)] -
    Don't use 'includes' subsection when specifying packages
-   [[BGBUILD-127](https://issues.jboss.org/browse/BGBUILD-127)] -
    Use appliance definition object instead of a file when using BG as
    a library
-   [[BGBUILD-128](https://issues.jboss.org/browse/BGBUILD-128)] -
    Allow to specify plugin configuration using CLI
-   [[BGBUILD-129](https://issues.jboss.org/browse/BGBUILD-129)] -
    Use partitions labels instead of device path in grub and fstab
-   [[BGBUILD-130](https://issues.jboss.org/browse/BGBUILD-130)] -
    Add virtio support out of the box
-   [[BGBUILD-133](https://issues.jboss.org/browse/BGBUILD-133)] -
    Support a consolidated configuration file
-   [[BGBUILD-134](https://issues.jboss.org/browse/BGBUILD-134)] -
    Replace rubygem-commander with rubygem-thor
-   [[BGBUILD-135](https://issues.jboss.org/browse/BGBUILD-135)] -
    Display the region name when reporting the registered ami
-   [[BGBUILD-137](https://issues.jboss.org/browse/BGBUILD-137)] -
    Show the appliance name in the ami registration notice
-   [[BGBUILD-147](https://issues.jboss.org/browse/BGBUILD-147)] -
    Allow to list installed plugins and version information

## Task

-   [[BGBUILD-5](https://issues.jboss.org/browse/BGBUILD-5)] - New
    platform plugin: VirtualBox
-   [[BGBUILD-120](https://issues.jboss.org/browse/BGBUILD-120)] -
    Add support for all EC2 regions
-   [[BGBUILD-121](https://issues.jboss.org/browse/BGBUILD-121)] -
    Use pvgrub for RHEL/CentOS 5
-   [[BGBUILD-126](https://issues.jboss.org/browse/BGBUILD-126)] -
    Use encrypted password in kickstart files
-   [[BGBUILD-131](https://issues.jboss.org/browse/BGBUILD-131)] -
    Check if OS is supported before executing the plugin
-   [[BGBUILD-140](https://issues.jboss.org/browse/BGBUILD-140)] -
    Update documentation to reflect plugin and CLI changes
