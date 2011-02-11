---
title: "BoxGrinder Build 0.7.1 released!"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder, boxgrinder_build, fedora ]
---

New
Year - new release! I decided to push out a bugfix release for
BoxGrinder Build because of one nasty bug:
[BGBUILD-124](https://issues.jboss.org/browse/BGBUILD-124) which
**prevented from mounting more that one partition in libguestfs**.

I removed also unused RPM database recreation code which is not
necessary after we
[dropped Fedora 11 and 12 support in 0.7.0](https://issues.jboss.org/browse/BGBUILD-117).

This update is immediately available for download from
[our repository](http://repo.boxgrinder.org/boxgrinder/)as well as
from Fedora updates-testing repo.
## Bug

-   [[BGBUILD-124](https://issues.jboss.org/browse/BGBUILD-124)] -
    Guestfs fails while mounting multiple partitions with '\_' prefix

## Task

-   [[BGBUILD-122](https://issues.jboss.org/browse/BGBUILD-122)] -
    Remove kernel recreation for Fedora EC2 images
-   [[BGBUILD-123](https://issues.jboss.org/browse/BGBUILD-123)] -
    Remove RPM database recreation code
-   [[BGBUILD-125](https://issues.jboss.org/browse/BGBUILD-125)] -
    Create kickstart files in RPM-based OS plugin in a temporary
    directory
