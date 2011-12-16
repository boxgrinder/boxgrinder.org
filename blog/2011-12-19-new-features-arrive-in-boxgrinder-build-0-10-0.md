---
title: "New features arriving in BoxGrinder Build 0.10.0"
author: 'Marek Goldmann'
layout: blog
version: 0.10.0
timestamp: 2011-12-19t13:11:00.10+02:00
tags: [ boxgrinder_build, openstack, libvirt, virtualpc ]
---

I'm really pleased to announce next major version of BoxGrinder Build. Version 0.10 includes many new exciting features.

## New plugin: libvirt delivery plugin

The most time consuming feature which was implemented by Marc is the [Libvirt](http://libvirt.org/) [delivery plugin](/tutorials/boxgrinder-build-plugins/#Libvirt_Delivery_Plugin). This plugin allows you to deliver the selected appliance to various platforms as libvirt supports many of them. Just to name few: KVM, Xen, VirtualBox.

// TODO


## New plugin: OpenStack delivery plugin

It's a pleasure to submit to testing [OpenStack](http://openstack.org/) plugin. OpenStack plugin allows you to deliver your appliance (in different formats) to [Glance](http://glance.openstack.org/) server using its REST API.

Usage of this plugin is very simple: if you want to submit a KVM image to OpenStack:

    boxgrinder-build definition.appl -d openstack

...and if you want to have an EC2 image registered:

    boxgrinder-build definition.appl -p ec2 -d openstack

Please refer to [plugin documentation](/tutorials/boxgrinder-build-plugins/#OpenStack_Delivery_Plugin). for detailed usage instructions.

This plugin is in a **tech-preview** state. This means that we haven't tested it very well, please help us with some testing. We really appreciate any comments and pull requests for this plugin.


## New plugin: VirtualPC platform plugin

If you need the appliance in VHD format which is required by Virtual PC or Citrix XenServer - there you have it. Usage is very simple:

    boxgrinder-build definition.appl -p virtualpc

This is an early stage of the plugin as we want to add more functionality in the future like thin/thick disk support.

## Kickstart support removal

As of now support for using [Kickstart files](http://fedoraproject.org/wiki/Anaconda/Kickstart) as input files for BoxGrinder Build is removed. Kickstart files support was the cause of confusion by many BoxGrinder users. They were expecting that the full plugin chain could be executed, but **this wasn't true since the beginning**. Only operating system plugin execution was tested, everything else was in the hand of gods.

We're now clear about the support: there is no support for kickstart files.

## Virtual machines disk alingment

This is not a direct feature of BoxGrinder but there was a fix commited to upstream appliance-tools which enables disk alingment by default. From now - all appliances made by BoxGrinder are aligned.

## New supported EC2 regions: sa-east-1 and us-west-2

You're now free to create your AMI's in new regions: sa-east-1 and us-west-2. More info about selecting the regions you can find in [S3 plugin documentation](/tutorials/boxgrinder-build-plugins/#S3_Delivery_Plugin).

Full release notes you can find below. If you have any comments - [find us or our community](/community/).

# Release Notes

## Bug

* [BGBUILD-152] - Clarification of Post section inheritance behaviour
* [BGBUILD-242] - Additional EBS overwrite edge cases
* [BGBUILD-243] - Misleading error messages when YUM mirrors/mirror-lists are unreachable.
* [BGBUILD-308] - bg-build 0.9.6 complains about file validation based upon file name
* [BGBUILD-313] - boxgrinder build fails to build ec2 image if ec2-user already exists
* [BGBUILD-323] - Invalid kernel version recognition makes recreating initrd impossible
* [BGBUILD-326] - BoxGrinder can fail when build run from / 

## Enhancement

* [BGBUILD-244] - No way for user to specify that they want to install optional packages when using yum groups 
* [BGBUILD-304] - Standarize plugin callbacks
* [BGBUILD-312] - Only use root privileges when necessary
* [BGBUILD-318] - Add support for us-west-2 region
* [BGBUILD-320] - support #ARCH# and/or #BASE_ARCH# replacement anywhere in the appliance definition file
* [BGBUILD-327] - Resolve appliance definition variables in ENV if they are not defined.

## Feature Request

* [BGBUILD-139] - Eucalyptus plugin
* [BGBUILD-157] - Add Alignment options for virtual appliances
* [BGBUILD-195] - Add support for OpenStack
* [BGBUILD-211] - Support for registering appliances with libvirt (KVM/XEN)
* [BGBUILD-234] - Host contributed appliance definition files
* [BGBUILD-267] - Add CentOS 6 support
* [BGBUILD-302] - Add support for VirtualPC platform
* [BGBUILD-322] - Allow to specify kernel and ramdisk for ec2 plugin
* [BGBUILD-331] - Add support for sa-east-1 EC2 region

## Task

* [BGBUILD-315] - Distribute qcow2 and thin vmdk disks for meta appliance
* [BGBUILD-325] - Remove kickstart support
* [BGBUILD-328] - Document libvirt plugin usage
* [BGBUILD-329] - Document openstack plugin usage
* [BGBUILD-330] - Document virtualpc plugin usage












