---
title: "BoxGrinder 0.6.4 released &#x2013; on the road to Fedora"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder_build, fedora, rpm ]
---


I'm
happy to announce next version of BoxGrinder Build: 0.6.4. This
release is a another minor build that moves us closer to Fedora. If
you're interested in this process – make sure you watch
[BoxGrinder Feature page](https://fedoraproject.org/wiki/Features/BoxGrinder)
on Fedora wiki. On 17th November
**[BoxGrinder](http://www.jboss.org/boxgrinder) was officially accepted as a feature for Fedora 15**
on [FESCo](http://fedoraproject.org/wiki/FESCo) meeting. See
[IRC log](http://meetbot.fedoraproject.org/teams/fesco/fesco.2010-11-17-18.30.log.html)
for details.

Most fixes in 0.6.4 are usability improvements. We
finally have **trace switch enabled by default** so we'll see the
full stacktrace and these errors are saved in log file – this will
help us to help you. We fixed also **VMware delivery**. Now you
unpack the VMware appliance and import it to your library. Still,
take a look at README provided with the package for more info.
# New nightly RPM repository

I prepared also a repository with BoxGrinder RPM nightly builds. We
build RPMs against Fedora rawhide, but this doesn't matter because
all packages we produce are noarch.

To add it to your system save
below content as /etc/yum.repos.d/boxgrinder-nightly.repo:

**[Update 23.01.2011]**

    [boxgrinder-nightly]
    name=BoxGrinder Nightly builds for Fedora 14
    baseurl=http://repo.ci.boxgrinder.org/fedora/14/RPMS/
    enabled=1
    gpgcheck=0

# How to update existing installations

To use the latest version execute the command below if you use our
RPM's:

    yum --enablerepo=updates-testing update rubygem-boxgrinder-*

In other cases use gem command
directly:

    gem list | cut -d" " -f1 | grep boxgrinder | xargs sudo gem update

# Release Notes

## Bug

-   [[BGBUILD-91](https://jira.jboss.org/browse/BGBUILD-91)] - Log
    exceptions to log file
-   [[BGBUILD-99](https://jira.jboss.org/browse/BGBUILD-99)] -
    Timeout exception is not caught on non-EC2 platfrom in
    GuestFSHelper

## Feature Request

-   [[BGBUILD-96](https://jira.jboss.org/browse/BGBUILD-96)] -
    Don't Require User to Rename VMware .vmdk and .vmx Files
-   [[BGBUILD-102](https://jira.jboss.org/browse/BGBUILD-102)] -
    Start X on boot when X Window System group or base-x group is
    specified

## Task

-   [[BGBUILD-92](https://jira.jboss.org/browse/BGBUILD-92)] -
    Enable --trace switch by default
-   [[BGBUILD-98](https://jira.jboss.org/browse/BGBUILD-98)] - Use
    hashery gem
