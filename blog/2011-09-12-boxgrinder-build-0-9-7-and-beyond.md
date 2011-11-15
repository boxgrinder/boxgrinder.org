---
title: "BoxGrinder Build 0.9.7 and beyond"
author: 'Marek Goldmann'
layout: blog
version: 0.9.7
timestamp: 2011-09-12t12:30:00.10+02:00
tags: [ boxgrinder_build ]
---

A week without BoxGrinder Build release is a lost week :) Let me introduce 0.9.7.

# What we broke in the previous release

This small bugfix release fixes some issues regarding the [newly introduced files section](/blog/2011/09/02/boxgrinder-build-0-9-6-with-files-support-is-out/) in 0.9.6.

We also discovered a change in systemd in Fedora 16 which prevented from executing our `/etc/rc.local` file which lead to unusable AMIs on AWS. The new systemd doesn't have a symlink from `/etc/rc.d/rc.local` to `/etc/rc.local`. Even more - a new condition was added to check for the executability for this file that doesn't work when the file is a symlink. See [#737047](https://bugzilla.redhat.com/show_bug.cgi?id=737047) for more info.

Due to a single character typo swap partitions didn't work for _some_ installations depending on Ruby and operating system combination. Pardon me.

This release is immediately available in the updates-testing Fedora repository.

# What we've done to avoid issues in the future

## First - issue causes

There are several types of issues that may arrive while developing BoxGrinder Build. Why? BoxGrinder Build isn't just a simple library. We integrate _very_ tightly with operating systems (Fedora, CentOS, RHEL), with our builder (appliance-creator) and with external services (AWS, SSH). If there is a change in some of these - we need to be prepared to handle it. Sometimes upstream introduces a breaking change. For us a change, for example in the file permissions of a single file in an operating system, can break the whole build...

There are of course also ordinary bugs in the code. Nobody is perfect.

## What can we do to break things more rarely?

The answer is tests. We have two kinds of tests in BoxGrinder Build: unit tests and integration tests. Unit tests should catch our code bugs, integration tests should catch bugs in the integration.

For our integration tests - **we just moved from stable repositories to updates-testing**. This way we can be prepared for upcoming changes in the operating systems. We constantly grow our unit tests collection.

We also want to change the way we introduce new features. **New features will be added only in major versions**, all minor versions will be bugfix only releases. In our case: 0.10.0 is a major version, 0.9.7 is a minor. We may change the version naming in the future to drop the zero in the front, but we'll leave it as is for now.

# What to expect after 0.9.7?

We want to stop the 0.9.x series and focus on 0.10.0 now. This means that 0.9.x will not have new releases anymore. Our main area of focus is support for new clouds:

1. OpenStack - almost done,
2. CloudStack - tricky, we'll spend some time on it.

We want to build appliances faster using a [pre-launched libguestfs service](https://issues.jboss.org/browse/BGBUILD-287) which is theorethically doable.

If you want see our current plans for 0.10.0 - just [take a look at our JIRA](https://issues.jboss.org/browse/BGBUILD/fixforversion/12315923). As always - our schedule is community-based. If you have some great ideas on how to make BoxGrinder better - [JIRA](https://issues.jboss.org/browse/BGBUILD) is waiting for you.

# Release Notes

## Bug
* [[BGBUILD–305][]] - Incorrect version information in 0.9.6 schema causing validation errors
* [[BGBUILD–307][]] - Appliance with swap file fails to build if selected OS is centos

## Task
* [[BGBUILD–306][]] - Switch for updates-testing repository for integration tests

[BGBUILD–305]: https://issues.jboss.org/browse/BGBUILD-305
[BGBUILD–307]: https://issues.jboss.org/browse/BGBUILD-307
[BGBUILD–306]: https://issues.jboss.org/browse/BGBUILD-306

