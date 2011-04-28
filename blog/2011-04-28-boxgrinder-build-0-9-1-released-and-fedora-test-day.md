---
title: "BoxGrinder Build 0.9.1 released and Fedora Test Day"
author: 'Marc Savy'
layout: blog
version: 0.9.1
timestamp: 2011-04-28t07:35:00.10+02:00
tags: [ boxgrinder_build ]
---

I'm happy to announce **BoxGrinder Build 0.9.1**. The release introduces a couple of new features, plus a number of bug-fixes and functionality enhancements. Please refer to the
[Release Notes][release_notes] below for a full list of the changes.

This release is immediately available from [BoxGrinder stable repo][repos] and will be 
available shortly in Fedora.

# What's New?
A quick overview of the most notable features, bug-fixes and enhancements arriving in 0.9.1
## ElasticHosts support  
As announced in our [previous blog post][elastichosts_provider_support], we've added support for the **[ElasticHosts Cloud Computing API][elastichosts_api]**, establishing support for a range of new Cloud Providers. You can find out more about the plugin, and some of the providers who use the ElasticHosts API via our [plugin documentation][elastichosts_docs] and [Support for New Clouds][elastichosts_provider_support] blog post.

## Clearing out any hangers-on
A minor annoyance in previous versions was that if you interrupted a build (possibly manually, or due to an error), it was possible that loop devices would be left hanging around until you manually removed them, or rebooted. However, [BGBUILD-97](https://issues.jboss.org/browse/BGBUILD-97) resolves that, and **now removes any unwanted mounts automatically**.

## Greatly improved parsing, validation and error messages for Appliance Definitions
With the aid of Kuwata Lab's [Kwalify](http://www.kuwata-lab.com/kwalify/), we have defined a schema for BoxGrinder Build Appliance Definitions, and implemented parsing and validation against it. Kwalify provides custom YAML parsing and validation, with strict syntax checking. A customised schema validator then checks the input against BoxGrinder's schema definitions, rapidly determining whether the input is conformant. **The change to schema validated input ensures that mistakes in appliance definitions are quickly identified, and precise error messages with line numbers are generated for the user**. 

Previously, many problems were not detected until the build process began, or caused run-time errors. This was liable to cause confusion, as it was often not immediately obvious where the problem originated from, as all filenames and line-numbers had been lost by this stage.  Furthermore, many subtle syntax errors or invalid fields were silently ignored.

For instance, a common mistake is to misspell a field, or introduce a syntax error;

    namee: whoops                       # Bad field name
    summary: just an example
    repos:
    - name: example-repo
      baseurl: zz:/invalid_repo_path    # Invalid repo path
      ephemeral: truee                  # Typo in value

With the improved parsing and validation, this now emits:

    I, INFO -- : Validating appliance definition from blah.appl file...
    E, ERROR -- : Error: [line 1, col 1] [/namee] key 'namee:' is undefined.
    E, ERROR -- : Error: [line 5, col 5] [/repos/0/baseurl] 'zz:/invalid_repo_path': not matched to pattern ...
    E, ERROR -- : Error: [line 6, col 5] [/repos/0/ephemeral] 'truee': not a boolean. # Must be true/false
    E, ERROR -- : Error: [line 1, col 1] [/] key 'name:' is required. # The field name we intended to type

You will be alerted to any errors that are possible to detect early, such as invalid field-names, patterns and value constraints. Those of you interested in the schemas, can find them the [BoxGrinder Core GitHub repo](https://github.com/boxgrinder/boxgrinder-core/tree/master/lib/boxgrinder-core/schemas).    

## CentOS VirtualBox appliances now work with the standard SATA controller!
As of VirtualBox 3.2 a virtual SATA controller is default for attaching disk devices such as VDIs. However, BoxGrinder was still producing IDE disks, which when associated with the standard SATA controller caused a Kernel panic at boot. [BGBUILD-155](https://issues.jboss.org/browse/BGBUILD-155) resolves the issue, with the VDI now conforming to the usual VirtualBox work-flow.

# Fedora Test Day

Today we have also a **[BoxGrinder Fedora Test Day](https://fedoraproject.org/wiki/Test_Day:2011-04-28_Cloud_SIG_BoxGrinder_Build)**. Help us with testing BoxGrinder! Join the #fedora-test-day IRC channel on irc.freenode.net and pick up some [test cases](https://fedoraproject.org/wiki/Test_Day:2011-04-28_Cloud_SIG_BoxGrinder_Build#Test_Cases). If you have any troubles we'll be there to assist you!

# Release notes

## Bug

* [[BGBUILD-97](https://issues.jboss.org/browse/BGBUILD-97)] - some filesystems dont get unmounted on BG interruption
* [[BGBUILD-155](https://issues.jboss.org/browse/BGBUILD-155)] - Images built on Centos5.x (el5) for VirtualBox kernel panic (/dev/root missing)
* [[BGBUILD-164](https://issues.jboss.org/browse/BGBUILD-164)] - Guestfs writes to /tmp/ by default, potentially filling the root filesystem
* [[BGBUILD-184](https://issues.jboss.org/browse/BGBUILD-184)] - Image fails to boot for Fedora 14 KVM appliance using virtio devices
* [[BGBUILD-185](https://issues.jboss.org/browse/BGBUILD-185)] - Cannot create partitions smaller than 1GB
* [[BGBUILD-189](https://issues.jboss.org/browse/BGBUILD-189)] - custom repos with a space bar in name won't work.
* [[BGBUILD-192](https://issues.jboss.org/browse/BGBUILD-192)] - Use IO.popen4 instead open4 gem on JRuby
* [[BGBUILD-196](https://issues.jboss.org/browse/BGBUILD-196)] - GuestFS fails mounting partitions where more then 3 partitions are present
* [[BGBUILD-198](https://issues.jboss.org/browse/BGBUILD-198)] - root password is not inherited
* [[BGBUILD-200](https://issues.jboss.org/browse/BGBUILD-200)] - /sbin/e2label: Filesystem has unsupported feature(s) while trying to open /dev/sda1
* [[BGBUILD-202](https://issues.jboss.org/browse/BGBUILD-202)] - Unable to get valid context for ec2-user after login on AMI

## Enhancement

* [[BGBUILD-156](https://issues.jboss.org/browse/BGBUILD-156)] - Validate appliance definition files early and return meaningful error messages
* [[BGBUILD-166](https://issues.jboss.org/browse/BGBUILD-166)] - Prevent gnome from auto-mounting device during build

## Feature Request

* [[BGBUILD-188](https://issues.jboss.org/browse/BGBUILD-188)] - Use libguestfs instead mounting partitions manually for EC2 appliances
* [[BGBUILD-190](https://issues.jboss.org/browse/BGBUILD-190)] - Allow to specify kernel variant (PAE or not) for Fedora OS
* [[BGBUILD-194](https://issues.jboss.org/browse/BGBUILD-194)] - Add support for ElasticHosts cloud

## Task

* [[BGBUILD-187](https://issues.jboss.org/browse/BGBUILD-187)] - Use UUIDs instead of labels for partitions

[0.9.0]: /blog/2011/03/09/boxgrinder-build-0-9-0-is-out/
[release_notes]: #Release_notes
[repos]: /tutorials/boxgrinder-rpm-repositories/
[elastichosts_provider_support]: /blog/2011/04/19/support-for-new-clouds-is-coming/
[elastichosts_docs]: /tutorials/boxgrinder-build-plugins/#ElasticHosts_Delivery_Plugin
[elastichosts_api]: http://www.elastichosts.com/cloud-hosting/api
