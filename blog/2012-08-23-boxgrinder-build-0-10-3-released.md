---
title: "BoxGrinder 0.10.3 Released"
author: 'Marc Savy'
layout: blog
version: 0.10.3
timestamp: 2012-08-23t15:55:00.10+01:00
tags: [ boxgrinder_build ]
---

We're happy to announce the long-awaited BoxGrinder Build 0.10.3 release. Yet again it is primarily bug fixes, but we have resolved some tricky upstream issues to eliminate some of the most annoying persistent issues.

## Large numbers of partitions
It is now possible to successfully create appliances with large numbers of partitions, whereas this generally failed when more than 4 or 5 partitions were specified previously. Furthermore, there should be fewer issues with the build process being interrupted by loop device symlinks left hanging around.

## Cross-arch building of RHEL and derivatives
On newer versions of Fedora cross-arch builds no longer completed successfully (i.e. `setarch i686 boxgrinder-build ...`); this has now been fixed upstream, and should work without issue.

Additionally, a separate issue on Fedora 17 has been resolved where our qemu wrapper did not find a valid binary.
     
## Found a bug?     
If you have any issues, please [open a ticket](https://issues.jboss.org/browse/BGBUILD) in our bug-tracker.

# Release notes
## Bug

* [BGBUILD-339] - existing rpm package with the name containing '+' considered as an invalid name
* [BGBUILD-358] - Unable to cross-arch build appliance for CentOS 5
* [BGBUILD-359] - Unable to create more that 2 partitions in Centos EBS-EC2.
* [BGBUILD-367] - Build fails with default_repos disabled on centos 5
* [BGBUILD-368] - /usr/bin/qemu: No such file or directory on Fedora 17 32-bit
