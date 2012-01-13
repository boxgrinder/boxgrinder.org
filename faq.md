---
layout: one-column
title: FAQ
---

((TOC))

***

# General

## Which operating systems are supported by BoxGrinder Build?

The [operating system section](http://boxgrinder.org/tutorials/boxgrinder-build-plugins/#Operating_system_plugins) of the plugins page provides the most contemporary information on which OSes BoxGrinder supports. Since verion 0.9.2 BoxGrinder Build has supported cross operating system builds, allowing your host to produce an appliance based upon a *different OS*. For instance, it is possible to *build a CentOS appliance using a Fedora host*.

> In fact, the recommended approach is to use Fedora 15 or 16 to build your appliances, which themselves may have *any* supported OS.

## On which operating systems can I run BoxGrinder Build?

Currently we **only support Fedora for building**. You need to have Fedora 15+ to build appliances with the latest BoxGrinder Build. We strongly encourange you to use latest available Fedora release.

> Note that you can still build appliances of any supported OS. For instance using Fedora 15 you can build a RHEL, CentOS or SL appliance using Fedora 15!  

Refer to the [above question](#What_operating_systems_are_supported_by_BoxGrinder_Build) for OSes that BoxGrinder can build into *appliances*.

## What is the location of supported Clouds in the world?

We have a [nice map](/cloud-locations/) to visualize it!

## How do I uninstall all of the BoxGrinder Build gems?

The easiest way to remove BoxGrinder is to simply use your package manager, for instance:
    
    yum remove -y rubygem-boxgrinder-build rubygem-boxgrinder-core

## How do I update BoxGrinder Build to the latest version?

For Fedora/RHEL/CentOS use YUM:

    yum update 'rubygem-boxgrinder-*'

## How can I use BoxGrinder Build without changing the user to root?

You can use [sudo](http://www.sudo.ws/sudo/sudo.man.html), or can you run `boxgrinder-build` as a **normal non-root user**, and BoxGrinder will re-launch itself as *root*, whilst preserving your environment. When *root* is no longer required, BoxGrinder will **switch back to your local user**. All files produced will be **owned by your local user**, and plugins will be able to access your **user's agents and environment** such as `ssh-agent` and `ssh-askpass`.

Simply **ensure the user can run sudo**: 

    some-usr$ boxgrinder-build my.appl
    
For convenience you can grant your regular user access to execute BoxGrinder Build command without entering the password. To do this run `visudo` as *root* and add this line:
    
    username        ALL=NOPASSWD: /usr/bin/boxgrinder-build

where *username* is your usual username.

## How can I prevent GNOME Desktop mounting appliance partitions during builds?

You can disable Nautilius automounting using this command:

    gconftool-2 --type bool --set /apps/nautilus/preferences/media_automount false

Alternatively you can use [`gconf-editor`](http://en.wikipedia.org/wiki/Gconf-editor).

# Amazon Web Services (EC2, S3...)

## Why can't I find my attached EBS volume?

If you use **Fedora 15+ or RHEL/CentOS 6+** AMIs built with BoxGrinder you need to search for `/dev/xvdX` instead of `/dev/sdX`. This is because we use a pv-grub AKI. 

For example: if you mount an EBS volume on `/dev/sdf`, look for it under `/dev/xvdf`.

## Why do I get 'Permission denied (publickey,gssapi-keyex,gssapi-with-mic)' when I try to log into a meta appliance instance?

You see this because the meta appliance installs the latest stable BoxGrinder Build release on boot, which prevents sshd from starting (and therefore prevents logins) until the update finishes. This can take several minutes depending upon the selected instance size.

## Why can't I log into my AMI as root via SSH?

AMIs should be accessed over SSH using `ec2-user` rather than `root`.  The `ec2-user` account has full `sudo` access without requiring a password (*NOPASSWD*).

## Why does BoxGrinder Build not function properly on some Xen-based RHEL/CentOS 5 hosts like AWS AMIs?

At present, [a bug in libguestfs](https://bugzilla.redhat.com/show_bug.cgi?id=539746#c9) results in only non-Xen kernels being looked for in /boot. You can work around this by installing a non-Xen kernel onto the AMI:

    yum install kernel
