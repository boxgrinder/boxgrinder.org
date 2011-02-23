---
title: "BoxGrinder Build 0.7.0 is out!"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder_build, cloud, ec2, fedora ]
---

I'm
pleased to announce new BoxGrinder Build release: 0.7.0. With this
release we fixed some issues, especially related to Fedora 14 on
EC2. There are also new nice features as well, read on! For full
change list read release notes below.
# Fedora 11 and 12 support removed

As Fedora 11 and 12 have reached End Of Life - we removed support
for creating appliance for this operating systems.
# EC2 appliances changes

We fixed some issues related to Fedora 14 on EC2. You can use now
**SElinux** with Fedora 13/14 on EC2 without issues! We introduced
another important change:
**you cannot log in now to your EC2 instance using root account - use ec2-user account instead**.
This user has full sudo access, without password, so you'll be
still able to execute administration tasks.
# VMware plugin update

[VMware plugin](http://community.jboss.org/docs/DOC-15528) was
updated to add thin disk support. This can save a lot of disk
space, especially when you use it on your laptop/desktop. With this
change we introduced a configuration file for VMware plugin. Below
you an find a sample configuration file:

    type: personal   # or enterprise
    thin_disk: true  # default: false

Please save the content under
**$HOME/.boxgrinder/plugins/vmware** file.
# New meta appliance

We released new meta appliance, version 1.3. With this release we
moved to Fedora 14 for our base system. You can grab meta appliance
in your favorite format from our
[download page](http://www.jboss.org/boxgrinder/downloads/build/meta-appliance).
Of curse there also EBS AMI's uploaded to Amazon!
# Fedora status

Almost all plugins are now in stable or updates-testing Fedora
repository. Remaining BoxGrinder plugins were submitted for a
review. You can watch current process status on
[BoxGrinder feature page](https://fedoraproject.org/wiki/Features/BoxGrinder#Current_status).
Feel free to review new packages or add comments to review
requests.

This means we're on time with BoxGrinder Fedora feature.
Now only waiting for positive review and I'll start the build
process!
## Euca2ools

Thanks to
[Pete](https://bugs.launchpad.net/euca2ools/+bug/665667/comments/9)
and
[Garrett](https://bugs.launchpad.net/euca2ools/+bug/665667/comments/10)
we finally have fixed euca2ools package that allows to build and
upload images to AWS.  This means that we can close
[BGBUILD-55](https://jira.jboss.org/browse/BGBUILD-55) and retire
ec2-ami-tools usage. This is very important because this allowed to
submit EC2-related plugins to Fedora!
# How to install

You can use our
[BoxGrinder RPM repository](http://repo.boxgrinder.org/boxgrinder/).
Make sure you enable updates-testing repo because
[euca2ools-1.3.1-4 is still in testing repository](https://admin.fedoraproject.org/updates/search/euca2ools-1.3.1-4):

    yum --enablerepo=updates-testing install rubygem-boxgrinder-*

# Release Notes

## Bug

-   [[BGBUILD-42](https://issues.jboss.org/browse/BGBUILD-42)] - No
    man pages installed in appliances
-   [[BGBUILD-119](https://issues.jboss.org/browse/BGBUILD-119)] -
    Fix SElinux issues on EC2 appliances

## Feature Request

-   [[BGBUILD-71](https://issues.jboss.org/browse/BGBUILD-71)] -
    Add support for growing (not pre-allocated) disks for VMware
-   [[BGBUILD-73](https://issues.jboss.org/browse/BGBUILD-73)] -
    Add support for kickstart files
-   [[BGBUILD-80](https://issues.jboss.org/browse/BGBUILD-80)] -
    VMware .tgz Bundle Should Expand Into Subdirectory, Not Current
    Directory
-   [[BGBUILD-110](https://issues.jboss.org/browse/BGBUILD-110)] -
    For EC2 images don't use root account, use ec2-user instead
-   [[BGBUILD-113](https://issues.jboss.org/browse/BGBUILD-113)] -
    Allow to specify supported file formats for operating system
    plugin

## Task

-   [[BGBUILD-55](https://issues.jboss.org/browse/BGBUILD-55)] -
    Use euca2ools instead of ec2-ami-tools
-   [[BGBUILD-59](https://issues.jboss.org/browse/BGBUILD-59)] -
    Remove all image modifications user is not expecting
-   [[BGBUILD-85](https://issues.jboss.org/browse/BGBUILD-85)] -
    Adjust BoxGrinder spec files for review
-   [[BGBUILD-114](https://issues.jboss.org/browse/BGBUILD-114)] -
    Update VMware disk geometry calculation
-   [[BGBUILD-115](https://issues.jboss.org/browse/BGBUILD-115)] -
    PackageHelper should take directory instead of file list to package
-   [[BGBUILD-117](https://issues.jboss.org/browse/BGBUILD-117)] -
    Remove Fedora 11 and 12 support
-   [[BGBUILD-118](https://issues.jboss.org/browse/BGBUILD-118)] -
    Enable SElinux in guestfs
