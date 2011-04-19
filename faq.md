---
layout: one-column
title: FAQ
---

((TOC))

***

# General

## What operating systems are supported by BoxGrinder Build?

See operating system plugins section on the [plugins page](/tutorials/boxgrinder-build-plugins). Bear in mind that building an appliance for a different operating system than you are currently running (eg. building Fedora on CentOS) is **not supported**.

## What is the location of supported Clouds in the world?

We have a [nice map](/cloud-locations/) to visualize it!

## How do I uninstall all of the BoxGrinder Build gems?

    gem list | cut -d" " -f1 | grep boxgrinder | xargs sudo gem uninstall -aIx

## How do I update all of the BoxGrinder Build plugins to latest versions?

For Fedora/RHEL/CentOS use YUM:

    yum update rubygem-boxgrinder-*

## How can I use BoxGrinder Build without changing the user to root?

You can use [sudo](http://www.sudo.ws/sudo/sudo.man.html). To make it convenient you can grant your regular user access to execute BoxGrinder Build command without entering the password. To do this run `visudo` as root and add this line at the end:

    username        ALL=NOPASSWD: /usr/bin/boxgrinder-build

where `username` is your regular user username.

## How can I prevent mounting partitions in my GNOME Desktop while building appliances?

You need to disable Nautilius automounting feature using this command:

    gconftool-2 --type bool --set /apps/nautilus/preferences/media_automount false

Alternatively you can use [`gconf-editor`](http://en.wikipedia.org/wiki/Gconf-editor).

# Amazon Web Services (EC2, S3...)

## Why can't I find my attached EBS volume?

If you use **Fedora 13+ or RHEL/CentOS 6+** AMIs built with BoxGrinder you need to search for `/dev/xvdX` instead of `/dev/sdX`. This is because we use a pv-grub AKI. Example: if you mount an EBS volume on `/dev/sdf`, look for it under `/dev/xvdf`.

## Why do I get 'Permission denied (publickey,gssapi-keyex,gssapi-with-mic)' when I try to log in to meta appliance instance?

You see it because the meta appliance installs the latest stable BoxGrinder Build release on boot, which prevents sshd from starting (and therefore prevents logins) until the install finishes. This can take several minutes depending on the selected instance size.

## Why can't I log into my AMI as root via SSH?

AMIs should be accessed over SSH using `ec2-user`, rather than `root`.  The `ec2-user` account has full `sudo` access, without password.

## Why does BoxGrinder Build not function properly on some Xen-based RHEL/CentOS 5 hosts like AWS AMIs?

At present, [a bug in libguestfs](https://bugzilla.redhat.com/show_bug.cgi?id=539746#c9) results in only non-Xen kernels being looked for in /boot. You can work around this by installing a non-Xen kernel onto the AMI:

    yum install kernel
