---
title: "BoxGrinder Build 0.6.5 released!"
author: 'Marek Goldmann'
layout: blog
tags: [ ami, boxgrinder_build, ec2, fedora ]
---


This
is mostly a bugfix release including one
[very important bug](https://jira.jboss.org/browse/BGBUILD-109). 32
bit AMIs produced by
[Fedora Cloud SIG](http://fedoraproject.org/wiki/Cloud_SIG) showed
up a nasty issue described in details in Red Hat Bugzilla
[bug report](https://bugzilla.redhat.com/show_bug.cgi?id=651861).
After great help from Jeff Darcy - we have now a
[workaround](https://bugzilla.redhat.com/show_bug.cgi?id=651861#c39).
This workaround is now implemented in BoxGrinder. So,
**if you want to build Fedora 14 AMI's - please update BoxGrinder to the latest version!**

Beginning with this version - BoxGrinder
**will not install ec2-ami-tools package by default for appliances converted to EC2 format**.
If you want still this package to be included in your AMI you need
to do this manually. There are two steps to do this:

1.  Put this package to a local repository and add it to packages
    section.
2.  Install the package using post section:

            post:
              ec2:
                - "rpm -Uvh http://s3.amazonaws.com/ec2-downloads/ec2-ami-tools.noarch.rpm"



# Release Notes

## Bug

-   [[BGBUILD-105](https://jira.jboss.org/browse/BGBUILD-105)] - No
    plugin-manager require for local delivery plugin
-   [[BGBUILD-106](https://jira.jboss.org/browse/BGBUILD-106)] - No
    plugin-manager require for fedora os plugin
-   [[BGBUILD-107](https://jira.jboss.org/browse/BGBUILD-107)] - No
    plugin-manager require for vmware platform plugin
-   [[BGBUILD-108](https://jira.jboss.org/browse/BGBUILD-108)] - No
    plugin-manager require for sftp delivery plugin
-   [[BGBUILD-109](https://jira.jboss.org/browse/BGBUILD-109)] -
    readdir64 bugfix for i386 base AMIs

## Task

-   [[BGBUILD-111](https://jira.jboss.org/browse/BGBUILD-111)] -
    Don't install ec2-ami-tools by default in AMIs
