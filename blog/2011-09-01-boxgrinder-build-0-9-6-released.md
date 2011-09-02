---
title: "BoxGrinder Build 0.9.6 released"
author: 'Marek Goldmann'
layout: blog
version: 0.9.6
timestamp: 2011-08-26t20:15:00.10+01:00
tags: [ boxgrinder_build ]
---

We continue our rapid development and release another minor update to BoxGrinder Build today: **0.9.6**.

This release includes mostly bugfixes, but we also have a neat surprise for you, read on.

# What's new in 0.9.6?

## GRUB fixes

We discovered some small issues that could prevent Xen/KVM/VMware appliances which used GRUB Legacy from running. Fixed!

## File section support

Many of you requested an easy way of including selected files into appliance, for example scripts. Our answer thusfar was:

1. Add your stuff to the post section, or
2. Create an RPM (which is fairly simple!) and add it to your packages list.

Now this is over! Let me introduce the files section:

    name: jeos-f16
    summary: fedora 16
    os:
      name: fedora
      version: 16
    files:
      "/opt":
        - "install_script.sh"
    post:
      base:
        - "chmod +x /opt/install_script.sh && /opt/install_script.sh"

This way you have an easy and fast method of including your files into appliances. Feel free to test it and let us know how you like it!

For more information about usage please refer to files section documentation.

## Swap support

We hadn't noticed earlier, but if you _really_ want to have swap space on your appliance - just specify another partition with **swap** as the mount point, like this:

    hardware:
      partitions:
        "/":
          size: 2
        "swap":
          size: 1

That's all for now. You'll hear more from us in the near future, stay tuned :)

# Release Notes

## Bug
* [[BGBUILD–298][]] - Fedora 16 or newer has networking issue on platforms different than EC2 because of biosdevname not disabled
* [[BGBUILD–299][]] - Wrong filenames in GRUB discovery

## Enhancement
* [[BGBUILD–300][]] - Add support for swap partitions

## Feature Request
* [[BGBUILD–276][]] - Import files into appliance via appliance definition file (Files section)

[BGBUILD–298]: https://issues.jboss.org/browse/BGBUILD-298
[BGBUILD–299]: https://issues.jboss.org/browse/BGBUILD-299
[BGBUILD–300]: https://issues.jboss.org/browse/BGBUILD-300
[BGBUILD–276]: https://issues.jboss.org/browse/BGBUILD-276

