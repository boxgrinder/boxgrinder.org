---
layout: one-column
title: FAQ
---

((TOC))

***

# General

## What operating systems are supported by BoxGrinder Build?

See operating system plugins section on the [plugins page](/tutorials/boxgrinder-build-plugins). Bear in mind that building an appliance for a different operating system than you are currently running (eg. building Fedora on CentOS) is **not supported**.

## How do I uninstall all of the BoxGrinder Build gems?

    gem list | cut -d" " -f1 | grep boxgrinder | xargs sudo gem uninstall -aIx

## How do I update all of the BoxGrinder Build plugins to latest versions?

For Fedora/RHEL/CentOS use YUM:

    yum update rubygem-boxgrinder-*

# Amazon Web Services (EC2, S3...)

## Why can't I find my attached EBS volume?

If you use **Fedora 13+ or RHEL/CentOS 6+** AMI's built with BoxGrinder you need to search for `/dev/xvdX` instead of `/dev/sdX`. This is because we use a pv-grub AKI. Example: if you mount an EBS volume on `/dev/sdf`, look for it under `/dev/xvdf`.

## Why do I get 'Permission denied (publickey,gssapi-keyex,gssapi-with-mic)' when I try to log in to meta appliance instance?

You see it because the meta appliance installs the latest stable BoxGrinder Build release on boot, which prevents sshd from starting (and therefore prevents logins) until the install finishes. This can take several minutes depending on the selected instance size.
