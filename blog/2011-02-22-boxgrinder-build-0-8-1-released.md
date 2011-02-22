---
title: "BoxGrinder Build 0.8.1 released!"
author: 'Marek Goldmann'
layout: blog
version: 0.8.1
tags: [ boxgrinder ]
---

I'm happy to announce **BoxGrinder Build 0.8.1**. This is a bugfix release. Please refer to the
[Release Notes][release_notes] below for a full list of bugfixes.

This release is immediately available from [BoxGrinder stable repo][repos] and will be 
available shortly in Fedora Rawhide.

# Some future ideas (your input needed!)

## Moving all plugins into boxgrinder-build gem?

In this release I fixed some [gem dependency issues][BGBUILD-165]. Currently we have **11 plugins** 
for BoxGrinder Build. Keeping the gemspec and RPM spec files up to date with the proper versions of all 
of the dependencies is difficult. I'm therefore considering including all of the plugins into the 
*boxgrinder-build* gem.

### Advantages:

* Simpler install - all of the plugins would be available with one install
* Simpler release process

### Disadvantages:

* All of the plugins with their dependencies would be installed, resulting in a bigger dependency tree
* Plugins you're not interested in would be installed too

**What's your opinion?** Please leave a comment.

## BoxGrinder 0.8.x in Fedora 13/14?

[BoxGrinder Build 0.8.0 was released][0.8.0] almost two weeks ago, but it hasn't yet made it into Fedora (you can of course
download the latest releases from [our repositories][repos], you don't need to wait for Fedora packages) due to [BGBUILD-165].
With [BGBUILD-165] now fixed, 0.8.x can be added to Fedora, though I haven't decided whether 0.8.x should land in Fedora 13 and 14.
If you have any thoughts on this, **please leave a comment**.

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
