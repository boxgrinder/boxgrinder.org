---
title: "BoxGrinder Build 0.4.0 released!"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder, plugins ]
---

I'm very excited to announce new BoxGrinder Build! Before I dive into technical details please let me explain some non-technical aspects. From this version we introduced a new versioning scheme. This will help us to play nice with RubyGems. It'll be "Linux kernel"-like versioning. I created a wiki page to explain it a bit more. If you have still questions, feel free to use our forums and ask.

Announced **0.4.0** release is a stable version.

Let me now highlight some important technical changes.

# New usage

After some releases based on [Rake](http://rake.rubyforge.org/) we decided to move away from it. Don't understand us wrong - Rake is great when you have many dependencies to be satisfied. It's just not good enough to use it as a command line application. Now we build our command line interface upon [Commander](http://github.com/visionmedia/commander).

What does it mean for you? You don't need to have <code>appliances/</code> directory to put there your appliance definitions - appliance definition is now specified as a command line argument:

    boxgrinder-build your-definition.appl

If you have dependent definitions, just put them in the same directory where your-definition.appl file is located; BoxGrinder Build will find it. As a side effect for moving away from Rake we have **increased the speed of building**. Earlier every appliance located under appliance/ directory was scanned, now only required appliance definitions are read.

The full usage instructions for new BoxGrinder Build are available [here](http://community.jboss.org/docs/DOC-15373).

# New architecture

BoxGrinder Build was rewritten to open the architecture for customization, aka plugins. We divided the task BoxGrinder is executing to three types of plugins:

1. **operating system** -- this type will create the base image that can be deployed on KVM with a RAW disk image. It's a great base to start converting it to selected platform, example: [Fedora](http://fedoraproject.org/) or [RHEL](http://www.redhat.com/rhel/) plugin.
2. **platform** -- this plugin will convert the disk image from operating system plugin to a format used by selected platform, example: EC2, VMware. It also creates the metadata required to launch the image on selected platform.
3. **delivery** -- this plugin will deliver the image produced by operating system or platform plugin and deliver the image to selected location. For example we may want to upload an image to S3 bucket, or register it as AMI, or upload to a remote server using SFTP, or simply move the image to another folder on our build machine.

Every plugin has its own types - to use a selected type you need to specify it in the command line. To build a base appliance (invoking only operating system plugin) execute:

    boxgrinder-build your-definition.appl

If you want to build it and convert to VMware format, use vmware platform type:

    boxgrinder-build your-definition.appl -p vmware

If you want to deliver this appliance to a sftp server, use sftp delivery type:

    boxgrinder-build your-definition.appl -p vmware -d sftp

Please note, that every delivery plugin has its own configuration file which needs to be adjusted. Consult the [plugin list page](http://community.jboss.org/docs/DOC-15214) where all plugins shipped with BoxGrinder Build are described.

Please bear in mind that platform plugins may or may not support all of the images built by operating system plugins. For example Fedora operating system plugin can build Fedora images from versions 11 to 13, but EC2 platform plugin supports only Fedora in version 11. The cause is that newer [Fedora requires newer kernels to be uploaded to EC2](https://fedoraproject.org/wiki/Features/FedoraOnEC2).

# New operating systems supported: RHEL 5 and CentOS 5

Yah, it's true - we have from now support for Red Hat Enterprise Linux 5 and CentOS 5. You can build appliances for your favorite operating system. And, yes, Fedora 13 is also supported! :)

# Installation and usage

We build also a new 1.1 meta appliance for you. You need only install BoxGrinder and you're ready to go. See also quick start page!

If you have any questions or problems, please let us know! Happy building!