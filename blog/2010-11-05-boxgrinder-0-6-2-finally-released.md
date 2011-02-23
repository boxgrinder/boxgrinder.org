---
title: "BoxGrinder 0.6.2 finally released!"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder_build, fedora ]
---

This
should be really a major release. We fixed many bugs, but that's
not everything – we added some great features too! I want highlight
two of them.
# Fedora 14 support

We support Fedora 14 almost on the day it was released! For all
platforms: VMware, KVM and EC2 (both S3 and EBS-based AMI's).
That's a great news for all Fedora lovers. I must admin this was a
very smooth update – Fedora 14 worked perfect, thanks for the hard
work on this sfotware!
# RPMs available for Fedora 13 and 14

As a part of
[ongoing inclusion process in Fedora](https://fedoraproject.org/wiki/Features/BoxGrinder)
- we released for the first time RPM's for BoxGrinder. Currently
these packages are hosted in
[our repository](http://repo.boxgrinder.org/boxgrinder/packages/),
therefore if you want to add BoxGrinder to your Fedora box - you'll
need to add this repo to your environment. In the future you'll be
able to install BoxGrinder directly from Fedora repos. To add
BoxGrinder to your box, just grab our repo definition and store it
in `/etc/yum.repos.d/` directory:

    curl http://repo.boxgrinder.org/boxgrinder/boxgrinder.repo > /etc/yum.repos.d/boxgrinder.repo
    yum install rubygem-boxgrinder-build-fedora-os-plugin


From now
this is the **preferred way of installing BoxGrinder on Fedora** -
please don't use gem command directly! If you have troubles -
please fill a new bug report in
[our issue tracker](https://jira.jboss.org/browse/BGBUILD).
# EBS-based EC2 meta appliance

Yes - we hear your voice. There is now
an [EBS-based meta appliance](http://www.jboss.org/boxgrinder/downloads/build/meta-appliance.html)
(version 1.2). This prevents your work from being lost on EC2.

As
usual - we're waiting for you in our IRC channel: \#boxgrinder on
irc.freenode.net and on
[our forums](http://community.jboss.org/en/boxgrinder?view=discussions).

Below you can find full list of fixed issues:
## Bug

-   [[BGBUILD-57](https://jira.jboss.org/browse/BGBUILD-57)] -
    Additional packages specified in EC2 plugin aren't installed
-   [[BGBUILD-61](https://jira.jboss.org/browse/BGBUILD-61)] - EBS
    availability\_zone should be defaulted to current running instance
    availability zone
-   [[BGBUILD-81](https://jira.jboss.org/browse/BGBUILD-81)] - post
    command execution w/ setarch breaks commands which are scripts
-   [[BGBUILD-82](https://jira.jboss.org/browse/BGBUILD-82)] - Root
    password not set when selinux packages are added
-   [[BGBUILD-84](https://jira.jboss.org/browse/BGBUILD-84)] -
    Don't use in libguestfs qemu-kvm where hardware accleration isn't
    available

## Feature Request

-   [[BGBUILD-70](https://jira.jboss.org/browse/BGBUILD-70)] -
    Enable Ephemeral Storage on EBS Images
-   [[BGBUILD-76](https://jira.jboss.org/browse/BGBUILD-76)] - Add
    swap to EBS AMI's

## Task

-   [[BGBUILD-63](https://jira.jboss.org/browse/BGBUILD-63)] - Use
    'aws' gem instead 'aws-s3' because it's already packaged in Fedora
-   [[BGBUILD-64](https://jira.jboss.org/browse/BGBUILD-64)] - Add
    support for Fedora 14
-   [[BGBUILD-65](https://jira.jboss.org/browse/BGBUILD-65)] -
    Allow to specify own repos overriding default repos provided for
    selected OS
-   [[BGBUILD-66](https://jira.jboss.org/browse/BGBUILD-66)] -
    Store tarred appliances files in s3-plugin/ dir for s3-plugin
-   [[BGBUILD-67](https://jira.jboss.org/browse/BGBUILD-67)] - Add
    Fedora 14 support for S3 delivery plugin and EBS delivery plugin
-   [[BGBUILD-33](https://jira.jboss.org/browse/BGBUILD-33)] -
    Create spec files for BoxGrinder for Fedora
