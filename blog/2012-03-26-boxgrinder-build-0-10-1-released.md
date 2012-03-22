---
title: "BoxGrinder 0.10.1 Released"
author: 'Marc Savy'
layout: blog
version: 0.10.1
timestamp: 2012-03-26t17:10:00.10+01:00
tags: [ boxgrinder_build ]
---

The long-awaited BoxGrinder Build 0.10.1 bugfix release is now available; with a variety of irritation eliminating alterations behaviour should be more consistent, and no longer prone to permissions errors.

## Permission denied, log shifting errors
If you have seen any errors akin to:

    FATAL -- : Logger::ShiftingError: Shifting failed. Permission denied - log/boxgrinder.log.2 or log/boxgrinder.log.3
    
The problem was caused when BoxGrinder switched to a local user from root, but the log file could still be owned by root. The issue was only apparent on certain systems, and even then often only occasionally.

## Ruby 1.9 
We've made some changes to ensure BoxGrinder runs correctly under Ruby 1.9, with a particular eye towards the forthcoming release of Fedora 17. You can see our earlier [musings](/blog/2012/02/29/preparing-for-fedora-17/) on the changes required.

## Scientific Linux EBS AMIs
OS constraints on the EBS plugin have been removed, so you can now create a Scientific Linux EBS AMIs. As the limitation is generally eliminated, any community OS plugin is also be able to use the EBS plugin.

## Bash tab completions
Basic bash tab completions have been sneaked into this release. Give it a try:

        [root@localhost ~]# boxgrinder-build my.appl --
        --backtrace        --delivery-config  --os-config        --plugins
        --debug            --force            --platform         --trace
        --delivery         --help             --platform-config  --version

## Other 
Snapshots with the S3 plugin are working correctly again, and some simple testing issues were fixed.
 
# Release notes

## Bug

* [BGBUILD-337] - In SL if default repos are disabled, /etc/yum.repos.d folder is not created
* [BGBUILD-338] - Weed out non-deterministic tests
* [BGBUILD-344] - Builds on some platforms impossible due to log (and/or other) files still being owned by root after boxgrinder switches to user
* [BGBUILD-351] - s3 plugin attempts to create bucket with whole pathname during snapshot

## Enhancement

* [BGBUILD-349] - Use RbConfig instead of obsolete and deprecated
  Config deprecation warning with Ruby 1.9.3

## Task 

* [BGBUILD-332] - Add support for bash completion
* [BGBUILD-346] - Confirm Ruby 1.9.3 support

# Sub-task

* [BGBUILD-348] - Simplecov coverage testing for Ruby >=1.9
