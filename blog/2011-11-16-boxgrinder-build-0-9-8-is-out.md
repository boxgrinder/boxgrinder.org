---
title: "BoxGrinder Build 0.9.8 is out"
author: 'Marek Goldmann'
layout: blog
version: 0.9.8
timestamp: 2011-11-16t13:11:00.10+02:00
tags: [ boxgrinder_build ]
---

It has been a long time we met last time! There are a few reasons. We both (Marc and me) were travelling a bit spreading the BoxGrinder love around the world. Marc is still working on a big BoxGrinder improvement - libvirt plugin. Additionally I was pulled into another task - making [JBoss AS 7 available in Fedora](http://fedoraproject.org/wiki/JBossAS7).

But hey, we found some time to release 0.9.8 :) Although we [planned to make 0.9.7 the last release of 0.9.x series](/blog/2011/09/12/boxgrinder-build-0-9-7-and-beyond/) - we were forced to do another one. The main reason was that [appliance-tools](http://thincrust.org/tooling.html) version shipped in Fedora 16 wasn't able to build appliances where [GRUB2](http://www.gnu.org/software/grub/) is the default boot loader. I took care of this and [pushed new appliance-tools version](https://admin.fedoraproject.org/updates/FEDORA-2011-15799) over the weekend, but it required some changes to how we use appliance-creator internally. So, there we have 0.9.8.

## CentOS 6 support

As a side effect of fixing appliance-creator - I added the ability to create CentOS 6 appliances. You'll even be able to create CentOS 6 AMIs now! Go, try it and let us know how it went!

## Preserving your environment, and limiting time as root

There are some use cases where people get confused about BoxGrinder not using their own environment variables when executing BoxGrinder Build using `sudo`. Thanks to Marc this is now over, yay! Even more - we'll make sure that the created artifacts have the expected owner, and drop down from root user to standard user (where applicable) as soon as possible.  This change also ensures that the user's agents such as `ssh-agent` are available to BoxGrinder, for instance for the SSH plugin or the upcoming libVirt plugin will seamlessly use your `ssh-agent` when required. Small things, but makes life easier.

To utilise it at its best, you can simply run `boxgrinder-build` **without** `sudo`. Although even under `sudo` and `su`, we now try to behave in a less surprising way.  

The release is **immediately available** in Fedora 15/16 updates-testing repository.

Full release notes you can find below. If you have any comments - [find us or our community](/community/).

# Release Notes

## Bug

* [[BGBUILD-310]] - BoxGrinder doesnt build appliances when Fedora 16 is the host
* [[BGBUILD-321]] - For EBS AMIs use the filesystem type specified for root partition

## Enhancement

* [[BGBUILD-312]] - Only use root privileges when necessary

## Feature Request

* [[BGBUILD-157]] - Add Alignment options for virtual appliances
* [[BGBUILD-267]] - Add CentOS 6 support

[BGBUILD-310]: https://issues.jboss.org/browse/BGBUILD-310
[BGBUILD-321]: https://issues.jboss.org/browse/BGBUILD-321
[BGBUILD-312]: https://issues.jboss.org/browse/BGBUILD-312
[BGBUILD-157]: https://issues.jboss.org/browse/BGBUILD-157
[BGBUILD-267]: https://issues.jboss.org/browse/BGBUILD-267
