---
title: "BoxGrinder Build 0.6.0 released!"
author: 'Marek Goldmann'
layout: blog
tags: [ aws, boxgrinder_build, ebs, meta-appliance ]
---

I'm
really happy to announce availability of BoxGrinder Build 0.6.0!
This is major release fixing many bugs. More, we added some great
feature I'm describing below and added some usability improvements
too! So, let's dive into new BoxGrinder!
# EBS AMI support

As I mentioned in
[earlier post](/blog/ebs-ami-support-for-boxgrinder) – we added
support for building EBS-based AMI's on Amazon Web Services. The
process is really easy – you just need bear in mind that you must
**execute the build on EC2** (we need to mount ESB volume) and
instance on which you want to build the EBS AMI is
**in the same region as you choose for the AMI**. But don't worry:
BoxGrinder will remind you about this if something is wrong :)

For
more info about EBS plugin please refer to
[EBS plugin page](http://community.jboss.org/docs/DOC-15921) on our
wiki or as directly on
[our forums](http://community.jboss.org/en/boxgrinder?view=discussions).
# Cross-arch building is now supported

From now you can build 32 bit appliances on 64 hosts. This is
supported for all OSes. If you have problems with it, please file a
[new ticket](https://jira.jboss.org/secure/CreateIssue.jspa?pid=12310920&issuetype=1)
in our tracking system. To build 32 bit appliances on 64 bit host
you need to use setarch command, for example:

    setarch i386 boxgrinder-build jeos.appl

That's all!

# Many bug fixes and usability improvements

We fixed (**with great help from our community!**) many bugs. Full
(well, almost) list of fixed bugs you can find
[here](https://jira.jboss.org/browse/BGBUILD/fixforversion/12315176).
Let's have a look at the improvements:
## Meta appliance has now bigger disk

We released a new version of
[meta appliance](http://www.jboss.org/boxgrinder/downloads/build/meta-appliance.html)
and yes it has a 10 GB root partition now! This means you don't
have to create and mount a new disk to build appliances. Still, if
you want to build AMI's – you need to have more free space. We
encourage you to use meta appliance AMI to build AMI's: you get two
things "for free":

-   a big /mnt partition where you can build the AMI
-   lighting fast upload to S3.

## Automatic Boxgrinder Build installation on meta appliance boot

In meta appliance version 1.1+ we install on boot latest BoxGrinder
Build. When the boot process finishes – you're ready to build your
appliances! Of course boot process will be slower – meta appliance
for slowest EC2 instance can boot 8 minutes. If you cannot log in
to meta appliance, please see our
[FAQ](http://community.jboss.org/docs/DOC-14544).
## Plugin design improvements

It's now easier to write plugins. We unified the interaction
between BasePlugin class and your plugin. Take a look at
[BGBUILD-26](https://jira.jboss.org/browse/BGBUILD-26). If you're a
plugin developer –
**don't miss our [plugin tutorial](https://community.jboss.org/docs/DOC-15555)**!

If you have any problems, please report it directly in our
[issue tracker](https://jira.jboss.org/browse/BGBUILD) or on our
[forums](http://community.jboss.org/en/boxgrinder?view=discussions)!
We appreciate your feedback! You can talk to us on IRC:
irc.freenode.net, channel \#boxgrinder.

Enjoy!