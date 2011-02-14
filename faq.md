---
layout: one-column
title: FAQ
---

((TOC))

***

# General

## What operating systems are supported by BoxGrinder Build?

See [Operating System matrix](#{site.links[:build_doc]}/operating_system_matrix). Bear in mind that building appliance for different operating system than currently running (eg. building Fedora on CentOS) is **not supported**.

## How do I uninstall all BoxGrinder Build gems?

    gem list | cut -d" " -f1 | grep boxgrinder | xargs sudo gem uninstall -aIx

## How to update all BoxGrinder Build plugins to latest versions?

For Fedora/RHEL/CentOS use YUM:

    yum update rubygem-boxgrinder-*

# Amazon Web Services (EC2, S3...)

## Why can't I find my attached EBS volume?

If you use **Fedora 13+ or RHEL/CentOS 6+** AMI's built with BoxGrinder you need to search for `/dev/xvdX` instead of `/dev/sdX`. This is because we use pv-grub AKI. Example: if you mount EBS volume on `/dev/sdf`, look for it under `/dev/xvdf`.

## Why do I get Permission denied (publickey,gssapi-keyex,gssapi-with-mic) when I try to log in to meta appliance instance?

You see it because we install latest stable available BoxGrinder Build release on boot. You'll be able to log in after the process is finished. This can take several minutes depending on instance size you selected.