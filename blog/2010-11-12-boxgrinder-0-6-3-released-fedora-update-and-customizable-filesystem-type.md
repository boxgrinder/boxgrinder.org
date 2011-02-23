---
title: "BoxGrinder 0.6.3 released &#x2013; Fedora update and customizable filesystem type"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder_build, fedora ]
---

We're
moving further with BoxGrinder! This release is a result of two
things:

1.  We fixed a few bugs that were failing builds on CentOS/RHEL 5.x
    thanks to our community!
2.  We finally started submitted BoxGrinder to Fedora!

# BoxGrinder in Fedora

**We started officially the process of BoxGrinder inclusion into Fedora.**
I created a
[BoxGrinder feature page](https://fedoraproject.org/wiki/Features/BoxGrinder).
Check it out and tell me what you think about it! We hope to have
BoxGrinder included in Fedora 15 as a feature. This means that
after Fedora 15 will be release BoxGrinder will be highlighted in
release notes and therefore more visible to users.

I submitted
several new RPM packages for review – you can find link on the
[feature page](https://fedoraproject.org/wiki/Features/BoxGrinder).
You can watch the progress there. I'll inform in next posts what's
the current status is sou you can help with testing if you want!

But don't worry – the plan is to include BoxGrinder for older
Fedora's too! We're going to push it to Fedora 13+.

# Customizable filesystem type and options

From now you can specify filesystem type and options for all
supported OSes. We support currently ext3 and ext4. Please make
sure when you specify the filesystem type you
**use one supported by selected OS**!

From now Fedora 13 and 14
default filesystem is **ext4**!

Below you can find a snippet how to
use it:

    hardware:
      partitions:
        "/":
          size: 2
          type: ext3
          options: "barrier=0,nodelalloc,nobh,noatime"
        "/home":
          size: 5
          type: ext4


# Release Notes

## Bug

-   [[BGBUILD-86](https://jira.jboss.org/browse/BGBUILD-86)] - EBS
    plugin should inform that it can be run only on EC2
-   [[BGBUILD-88](https://jira.jboss.org/browse/BGBUILD-88)] -
    CentOS plugin uses \#ARCH\# instead of \#BASE\_ARCH\#
-   [[BGBUILD-94](https://jira.jboss.org/browse/BGBUILD-94)] -
    Check if set\_network call is avaialbe in libguestfs

## Task

-   [[BGBUILD-65](https://jira.jboss.org/browse/BGBUILD-65)] -
    Allow to specify own repos overriding default repos provided for
    selected OS
-   [[BGBUILD-87](https://jira.jboss.org/browse/BGBUILD-87)] - Set
    default filesystem to ext4 for Fedora 13+
