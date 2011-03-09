---
title: "BoxGrinder Build 0.9.0 is out!"
author: 'Marek Goldmann'
layout: blog
version: 0.9.0
timestamp: 2011-03-09t13:50:00.10+01:00
tags: [ boxgrinder_build, fedora, release ]
---

# Yeah!

I'm really happy to announce next major release of **[BoxGrinder Build](/build): 0.9.0**! This release includes many bug fixes and most importantly - some requested features. See [release notes][release_notes] for a detailed list of issues.

# What's new?

## Packaging

In the previous version we packaged every [BoxGrinder plugin](/tutorials/boxgrinder-build-plugins/) in its own Gem (and then RPM). This wasn't great because the amount of time to maintain versions and dependencies between plugins was too big. Instead of adding new great features I was involved in fixing packaging bugs.

**But not anymore!  Now we only ship 2 gems**:

1. `boxgrinder-core`
2. `boxgrinder-build`

See [quick start](/tutorials/boxgrinder-build-quick-start/) for updated installation instructions.

## Fedora 15 support

You can already build **Fedora 15** appliances. You don't even need to wait for final release Enjoy!

## New (old) CLI and package format

BoxGrinder Build 0.8.x wasn't pushed to Fedora because our CLI changed and we didn't want to break your scripts. With 0.9.0 we're back to our old CLI enhanced with changes from 0.8.x.

If you're confused, feel free to read the [BoxGrinder Build usage page](/tutorials/boxgrinder-build-usage-instructions/) which shows the current state.

To make the BoxGrinder Build backward-compatible, we added support for our legacy packages section format:

Old format:

    packages:
      includes:
        - mc

New format:

    packages:
      - mc

Please note that **if you use the old format, a warning will be displayed, but the build will not break**. Old format support will be dropped in the future.

# Fedora news

[Fedora 15 Alpha was released yesterday](http://fedoraproject.org/wiki/Fedora_15_Alpha_release_notes)! From my (Marek) side I would like to thank the Fedora team for their hard work!

BoxGrinder is part of Fedora 13 and 14 since December 2010, but for Fedora 15 BoxGrinder is [highlighted as a feature](http://fedoraproject.org/wiki/Features/BoxGrinder). This wouldn't be possible without the [Cloud SIG](http://fedoraproject.org/wiki/Cloud_SIG) support! Thank you!

Did you know that BoxGrinder is the **first [JBoss](http://www.jboss.org/) project included in Fedora**? Yep, we're special :)

# New meta appliances

We've rebuilt the [meta appliance](/tutorials/boxgrinder-build-meta-appliance/) and released version 1.4 today. It's available from our [meta appliance download site](/download/boxgrinder-build-meta-appliance/). Feel free to use it to build your own appliances.

# New to BoxGrinder? Need some help?

We have prepared some [tutorials](/tutorials) and a [FAQ](/faq). We're also available on [IRC](irc://irc.freenode.net/boxgrinder) or [forums](http://community.jboss.org/en/boxgrinder?view=discussions) for you. Feel free to jump in and chat with us!

# Release notes

##  Bug

  * [[BGBUILD-81][33]] - post command execution w/ setarch breaks commands which are scripts
  * [[BGBUILD-162][34]] - SFTP delivery plugin fails on Centos 5 in all configurations
  * [[BGBUILD-169][35]] - All EC2 builds fail to build, fail to run, or hang at runtime.
  * [[BGBUILD-173][36]] - Include setarch package in default package list for RPM-based OSes
  * [[BGBUILD-176][37]] - Fail the build with appropriate message if any of post section commands fails to execute
  * [[BGBUILD-177][38]] - Fedora 13 builds have enabled firewall although they shouldn&#39;t have it
  * [[BGBUILD-180][39]] - F14 AMI fails to launch
  * [[BGBUILD-181][40]] - eucatools python shebang replacement on EL5 not occuring
  * [[BGBUILD-182][41]] - Creating AMI fails when build is already done and just attempting to deliver it

   [33]: https://issues.jboss.org/browse/BGBUILD-81
   [34]: https://issues.jboss.org/browse/BGBUILD-162
   [35]: https://issues.jboss.org/browse/BGBUILD-169
   [36]: https://issues.jboss.org/browse/BGBUILD-173
   [37]: https://issues.jboss.org/browse/BGBUILD-176
   [38]: https://issues.jboss.org/browse/BGBUILD-177
   [39]: https://issues.jboss.org/browse/BGBUILD-180
   [40]: https://issues.jboss.org/browse/BGBUILD-181
   [41]: https://issues.jboss.org/browse/BGBUILD-182

##  Feature Request

  * [[BGBUILD-103][42]] - README to indicate supported operating systems / requirements
  * [[BGBUILD-158][43]] - Include bundler gem on meta appliance
  * [[BGBUILD-159][44]] - Would be handy if meta included `createrepo`
  * [[BGBUILD-174][45]] - Move plugins to boxgrinder-build gem
  * [[BGBUILD-178][46]] - Remove sensitive data from logs
  * [[BGBUILD-183][47]] - Add support for Fedora 15

   [42]: https://issues.jboss.org/browse/BGBUILD-103
   [43]: https://issues.jboss.org/browse/BGBUILD-158
   [44]: https://issues.jboss.org/browse/BGBUILD-159
   [45]: https://issues.jboss.org/browse/BGBUILD-174
   [46]: https://issues.jboss.org/browse/BGBUILD-178
   [47]: https://issues.jboss.org/browse/BGBUILD-183

##  Task

  * [[BGBUILD-168][48]] - Add support for old-style packages section in appliance definition format
  * [[BGBUILD-175][49]] - Rewrite boxgrinder CLI to remove thor dependency
  * [[BGBUILD-179][50]] - Boolean and numeric parameters in hash-like values are not recognized

   [48]: https://issues.jboss.org/browse/BGBUILD-168
   [49]: https://issues.jboss.org/browse/BGBUILD-175
   [50]: https://issues.jboss.org/browse/BGBUILD-179


[release_notes]: #Release_notes
