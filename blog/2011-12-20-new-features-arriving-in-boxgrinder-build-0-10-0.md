---
title: "New features arriving in BoxGrinder Build 0.10.0"
author: 'BoxGrinder Team'
layout: blog
version: 0.10.0
timestamp: 2011-12-20t14:20:00.10+02:00
tags: [ boxgrinder_build, openstack, libvirt, virtualpc ]
---

We are really pleased to announce the next major version of BoxGrinder Build. Version 0.10 includes many exciting new features.

## New plugin: libvirt delivery plugin

The most time-consuming feature was the [libvirt](http://libvirt.org/) [delivery plugin](/tutorials/boxgrinder-build-plugins/#libvirt_Delivery_Plugin), enabling appliances to be delivered and registered on the range of platforms that [libvirt supports](http://libvirt.org/index.html).  These include KVM, Xen, VirtualBox and VMWare to name but a few, and whilst the current release of the plugin is a preview, we hope that your feedback will enable us to continue improving it, so please let us know your thoughts!

There are a large number of [features and configurable options](/tutorials/boxgrinder-build-plugins/#Libvirt_Delivery_Plugin) available, so we shall limit ourselves to some simple examples. We encourage you to consult [the documentation](/tutorials/boxgrinder-build-plugins/#libvirt_Delivery_Plugin) for detailed information.

### Examples
Deliver the appliance to a `qemu` hypervisor on the local machine, placing the appliance in the `/var/lib/libvirt/images` directory, and register the image:  

    boxgrinder-build definition.appl -d libvirt --delivery-config connection_uri:qemu:///system,image_delivery_uri:/var/lib/libvirt/images  

>The plugin will attempt to determine optimal settings by probing the libvirt daemon for its capabilities. If, for instance, the libvirtd residing at the `connection_uri` machine advertises that it supports `kvm`, this will be preferred over a slower `qemu` domain. You can, of course, override these settings manually.

Connect via SSH to a remote `vbox` (VirtualBox) [hypervisor](http://libvirt.org/drvvbox.html). Deliver the appliance via SFTP to the remote machine and register:   

    [...] -d libvirt --delivery-config connection_uri:vbox+ssh://root@example.org/session,image_delivery_uri:sftp://root@example.org/var/lib/libvirt/images
    
>In the above example, we assume that you have set up your [_ssh-agent_](http://mah.everybody.org/docs/ssh), thus enabling the plugin to seamlessly use key authentication for both libvirt and SFTP. Password authentication works too, but it requires you to enter a password each time the plugin needs to connect, which is rather inconvenient.  

There are a plethora of further features to allow arbitrary modification of domain definitions. Futhermore, we hope to make the plugin more user-friendly for those who require complex configurations, and these are topics we shall blog on in the future. 

## New plugin: OpenStack delivery plugin

It's a pleasure to submit to testing our [OpenStack](http://openstack.org/) plugin. The OpenStack plugin allows you to deliver your appliance (in different formats) to a [Glance](http://glance.openstack.org/) server using its REST API.

Usage of this plugin is very simple. If you want to submit a KVM image to OpenStack:

    boxgrinder-build definition.appl -d openstack

...and if you want to have an EC2 image registered:

    boxgrinder-build definition.appl -p ec2 -d openstack

Please refer to [plugin documentation](/tutorials/boxgrinder-build-plugins/#OpenStack_Delivery_Plugin) for detailed usage instructions.

This plugin is in a **tech-preview** state. This means that we haven't tested it intensively, please help us with some testing. We really appreciate any comments and pull requests for this plugin.


## New plugin: VirtualPC platform plugin

If you need the appliance in VHD format which is required by Virtual PC or Citrix XenServer - there you have it. Usage is very simple:

    boxgrinder-build definition.appl -p virtualpc

This is an early stage of the plugin as we want to add more functionality in the future like thin/thick disk support.

## Kickstart support removal

As of now support for using [Kickstart files](http://fedoraproject.org/wiki/Anaconda/Kickstart) as input files for BoxGrinder Build is removed. Kickstart files support was the cause of confusion by many BoxGrinder users. They were expecting that the full plugin chain could be executed, but **this wasn't ever true**. Only operating system plugin execution was tested, everything else was in the hand of gods.

We're now clear about the support: there is no support for kickstart files.

## Virtual machines disk alingment

This is not a direct feature of BoxGrinder, but there was a fix commited to the upstream appliance-tools which enables disk alignment by default. From now on, all appliances made by BoxGrinder are aligned.

## New supported EC2 regions: sa-east-1 and us-west-2

You're now free to create your AMI's in new regions: sa-east-1 and us-west-2. More info about selecting the regions you can find in [S3 plugin documentation](/tutorials/boxgrinder-build-plugins/#S3_Delivery_Plugin).

## Enhanced support for variables (parameters) in any string value field of an appliance definition

As requested by the community, it is now possible to use [variables](http://boxgrinder.org/tutorials/appliance-definition-parameters/) in *any* value field of an appliance: 

    name: boxgrinder-#OS_NAME#
    os:
      name: fedora
      version: 16

Furthermore, you may now **inject custom variables from your environment** into your appliances simply by defining them.

    $ export MY_ENV="I-LOVE-BoxGrinder"
    
    [...]
      base:
        - "mkdir #MY_ENV#" # This becomes "mkdir I-LOVE-BoxGrinder"

> There is a hierarchy in which a variable defined in the *variables* section of an appliance takes precedence over one defined in the environment. See our [mailing list post](http://markmail.org/message/we5abw2bwon36uva) for more detail.    

As an added bonus it is now also possible to **define nested variables**.  BoxGrinder can now resolve the following variable *#A#* successfully as *BoxGrinder Rocks!*:

    #A#: #B# #C#!
    #B#: BoxGrinder
    #C#: Rocks
    
> You could define these variables either in the *variables* section of your appliance, or in the environment. The variables section is better for portability, whereas the environment is useful for baking in one-shot customisations such as fixed MAC addresses. 

Full release notes can be found below. If you have any comments - [find us or our community](/community/).

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
 
* [BGBUILD-304] - Standarize plugin callbacks
* [BGBUILD-312] - Only use root privileges when necessary
* [BGBUILD-318] - Add support for us-west-2 region
* [BGBUILD-320] - support #ARCH# and/or #BASE_ARCH# replacement anywhere in the appliance definition file
* [BGBUILD-327] - Resolve appliance definition variables in ENV if they are not defined.

## Feature Request

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





