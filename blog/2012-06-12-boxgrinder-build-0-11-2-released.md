---
title: "BoxGrinder 0.10.2 Released"
author: 'Marc Savy'
layout: blog
version: 0.10.2
timestamp: 2012-06-13t18:00:00.10+01:00
tags: [ boxgrinder_build ]
---

The bug-fix release BoxGrinder Build 0.10.2 is available. It contains a couple of important fixes which have been breaking people's S3 AMI appliances on Amazon EC2. You can refer to our previous blog post [about it][], but put tersely, you should be able to successfully run appliances on any EC2 instance size without issue now!

We've managed to sneak in an extra feature however...

## Fedora 17 support

Huzzah, Fedora 17 support is here and working well. You can build an appliance in the usual manner, simply write your appliance definition specifying *fedora 17* as your OS name and version:

    name: my-super-cool-fedora-17-appliance
    os:
      name: fedora
      version: 17
     
If you have any issues with the new OS, please [open a ticket](https://issues.jboss.org/browse/BGBUILD) in our bug-tracker.

# Release notes
## Bug

* [BGBUILD-361] - CentOS 5 ec2 platform plugin issues, yum runs before having a proper /etc/resolv.conf and fails to resolve mirrors (Error: Cannot find a valid baseurl for repo: base)
* [BGBUILD-353] - Images not bootable on new type of AWS instances
* [BGBUILD-347] - Add support for Fedora 17

[about it]: /blog/2012/04/20/ebs-and-s3-ami-changes/
