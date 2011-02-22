---
title: "BoxGrinder Build 0.8.1 released!"
author: 'Marek Goldmann'
layout: blog
version: 0.8.1
tags: [ boxgrinder ]
---

I'm happy to announce new **BoxGrinder Build 0.8.1**. This is a bugfix release. Please refer to
[Release Notes][release_notes] below for a full list of bugfixes.

This release is immediately available from [BoxGrinder stable repo][repos] and will be available shorty in Fedora Rawhide.

# Some future ideas (your input needed!)

## Moving all plugins into boxgrinder-build gem?

In this release I fixed some [gem dependencies issues][BGBUILD-165]. Currently we have **11 plugins** for BoxGrinder Build. Having up to date
gemspec and RPM spec files with proper version of all dependencies is very hard. I think about including all
plugins into *boxgrinder-build* gem.

### Advantages:

* Simpler install - all plugins ready to work
* Simpler release process

### Disadvantages:

* All plugins with dependencies installed - bigger dependency tree
* Plugins you're not interested in would be installed too

**What's your opinion?** Please leave a comment.

## BoxGrinder 0.8.x in Fedora 13/14?

[BoxGrinder Build 0.8.0 was released][0.8.0] almost two weeks ago, but it hadn't make into Fedora yet (you can of course
download latest releases from [our repositories][repos], you don't need to wait for Fedora packages). Fixing
[BGBUILD-165] makes it finally possbile. I haven't still decided whether 0.8.x should land in Fedora 13 and 14.
If you have some thoughts on this, **please leave a comment**.

# Release notes

## Bug

* [[BGBUILD-141]] - Long delay after "Preparing guestfs" message when creating new image
* [[BGBUILD-142](https://issues.jboss.org/browse/BGBUILD-142)] - Backtraces make output unreadable - add option to enable them, and disable by default
* [[BGBUILD-150](https://issues.jboss.org/browse/BGBUILD-150)] - Cyclical inclusion dependencies in appliance definition files are not detected/handled
* [[BGBUILD-161](https://issues.jboss.org/browse/BGBUILD-161)] - Local delivery plugin does not deliver appliance to target path if packaging set to false
* [[BGBUILD-165]] - Use version in dependencies in gem and in RPM only where necessary

[0.8.0]: /blog/2011/02/09/boxgrinder-build-0-8-0-released-finally/
[release_notes]: #Release_notes
[repos]: /tutorials/boxgrinder-rpm-repositories/
[BGBUILD-141]: https://issues.jboss.org/browse/BGBUILD-141
[BGBUILD-165]: https://issues.jboss.org/browse/BGBUILD-165