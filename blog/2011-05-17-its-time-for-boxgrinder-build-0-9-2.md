---
title: "It's time for BoxGrinder Build 0.9.2"
author: 'Marek Goldmann'
layout: blog
version: 0.9.2
timestamp: 2011-05-17t07:35:00.10+02:00
tags: [ boxgrinder_build, meta_appliance, fedora ]
---

I'm very happy to announce a new version of [BoxGrinder Build](/build/). This release contains many new features and enhancements.

# What's new?

## CloudSigma support

In this version we added [CloudSigma](http://cloudsigma.com/) support. CloudSigma is a very popular IaaS Cloud provider in
Europe, based in Switzerland. To create a server for CloudSigma use our ElasticHosts plugin. Read more on the [plugin page](/tutorials/boxgrinder-build-plugins/#ElasticHosts_Delivery_Plugin).

We will soon provide a tutorial on how to use  BoxGrinder with CloudSigma.

## Better Fedora 15 support

Previous versions of BoxGrinder Build had Fedora 15 support, but we found a few issues (networking, `/etc/mtab`). This version addresses all of them - **now you can fully enjoy Fedora 15**.

## New meta appliance

We decided to switch to Fedora 15 as our base operating system for the meta appliance. This means that **we have prepared new meta appliances for you**.
Go and [download them](/download/boxgrinder-build-meta-appliance/) now.

## Cross-operating system builds working now! 

Yes, it's true - we added support for cross-operating system builds.  For example, this means that **you can build a RHEL 5 guest on a Fedora 15 host**!
Please make sure you run the build on a host with "newer" version of the operating system when compared to guest operating system version.

# Need help?

Our [community](/community/) is ready to help you!

# Release Notes

## Bug

-   [[BGBUILD-203][]] - Vmware vmdk disk size is wrong when installing
    via kickstart files
-   [[BGBUILD-204][]] - Fedora 15 appliance networking start on boot
    failed
-   [[BGBUILD-205][]] - Error while converting to EC2 when guest OS is
    CentOS/RHEL 5
-   [[BGBUILD-206][]] - Error while converting appliance to EC2 format
    when host is Fedora 14 and guest CentOS 5
-   [[BGBUILD-207][]] - Guestfs dies on Fedora 15 with ‘KVM not
    supported for this target’ message
-   [[BGBUILD-208][]] - Kickstart files not working with 0.9.1
-   [[BGBUILD-209][]] - Wrong /etc/mtab on Fedora 15 appliances causes
    errors
-   [[BGBUILD-210][]] - In Fedora 14 parameters are not being expanded,
    and cause early string truncation.
-   [[BGBUILD-212][]] - path: value not escaped in local
-   [[BGBUILD-214][]] - VMDK disk size is wrong when the vmware-plugin
    and centos-plugin are run together
-   [[BGBUILD-218][]] - Incorrect error messages since revision of
    parser/validator

## Feature Request

-   [[BGBUILD-83][]] - Enable libguestfs log callback to redirect
    guestfs output to logger
-   [[BGBUILD-148][]] - Add support for building CentOS/RHEL images on
    Fedora
-   [[BGBUILD-213][]] - CloudSigma support

  [BGBUILD-203]: https://issues.jboss.org/browse/BGBUILD-203
  [BGBUILD-204]: https://issues.jboss.org/browse/BGBUILD-204
  [BGBUILD-205]: https://issues.jboss.org/browse/BGBUILD-205
  [BGBUILD-206]: https://issues.jboss.org/browse/BGBUILD-206
  [BGBUILD-207]: https://issues.jboss.org/browse/BGBUILD-207
  [BGBUILD-208]: https://issues.jboss.org/browse/BGBUILD-208
  [BGBUILD-209]: https://issues.jboss.org/browse/BGBUILD-209
  [BGBUILD-210]: https://issues.jboss.org/browse/BGBUILD-210
  [BGBUILD-212]: https://issues.jboss.org/browse/BGBUILD-212
  [BGBUILD-214]: https://issues.jboss.org/browse/BGBUILD-214
  [BGBUILD-218]: https://issues.jboss.org/browse/BGBUILD-218
  [BGBUILD-83]: https://issues.jboss.org/browse/BGBUILD-83
  [BGBUILD-148]: https://issues.jboss.org/browse/BGBUILD-148
  [BGBUILD-213]: https://issues.jboss.org/browse/BGBUILD-213
