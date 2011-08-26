---
title: "BoxGrinder Build 0.9.5 released"
author: 'Marc Savy'
layout: blog
release: 0.9.5
timestamp: 2011-08-18t19:32:00.10+01:00
tags: [ boxgrinder_build, boxgrinder_meta ]
---

# BoxGrinder Build 0.9.5 released
We are pleased to announce the immediate availablity of BoxGrinder Build 0.9.5.

# What's new?

## Fedora 16 support
Fedora 16 has just reached [alpha status][], and to coincide with this event BoxGrinder Build now provides build support, allowing you to produced Fedora 16 based appliances; including EC2 and EBS based images!

This comes with a caveat at present, the current Fedora 16 kernel suffers from the same [device ordering problems][Trouble booting Fedora 15 S3 AMIs] that occurred with Fedora 15. There is a workaround however, by adding the updates-testing repository into the build: 

    name: jeos-f16
    summary: fedora 16 jeos!
    os:
      name: fedora
      version: 16
    repos:
      - name: "temp-fedora-updates-testing"
        mirrorlist: "https://mirrors.fedoraproject.org/metalink?repo=updates-testing-f#OS_VERSION#&arch=#BASE_ARCH#"
        ephemeral: true
        
>> Once the fixed kernel is in the stable repositories, you won't need this workaround, simply remove the temporary repository entry.
    
## 0.9.4 Errata
This release fixes some bugs that were mistakenly introduced into the S3 and EBS plugins during a rebase of a development branch. The net effect of this was that flaws not present in the tested development branch were accidentally created in the release.

We have improved integration tests to ensure this cannot happen easily again. 

# Other issues

## When will CentOS 6 support arrive?
Presently, we are awaiting the resolution of a [CentOS 6 bug][], and hope to provide build support as soon as the blocker is cleared.  You can follow our progress on ticket [[BGBUILD-267][]].

## Trouble booting Fedora 15 S3 AMIs
A problematic kernel update (kernel-2.6.40-4.fc15) rendered many Fedora 15 S3 backed AMIs unable to boot, as detailed in [RHBZ 729340][]. The issue has since been rectified, however any Fedora 15 appliances you may have built that used the aforementioned kernel will not function properly, and should be rebuilt. The fixed kernel is in the stable repositories, so simply doing a forced rebuild of any failed Fedora 15 appliances should produce a working machine.

The bug caused device naming to be offset, so whilst Fedora was expecting a root block device named `xvda1`, it was instead assigned the label `xvde1`. You should use `yum update kernel` to ensure you have the latest kernel installed, and if you were unfortunate enough to have an EBS instance rendered unbootable by the bug then you may be able to revive it with the [solution provided][] by community member _jrosengren_.

## S3 overwrite issues
Particularly observant readers will recall that in the [0.9.4 release blog][] a bug in `aws-sdk` library was mentioned, which caused BoxGrinder Build's S3 AMI _overwrite_ feature to fail. Subsequently a [new release](http://aws.amazon.com/releasenotes/Ruby/1188396596851115) has been made that fixes the issue, and this has now been packaged and pushed to the Fedora repositories. The issue is no longer be apparent in 0.9.4 or 0.9.5.

[BGBUILD-267]: https://issues.jboss.org/browse/BGBUILD-267
[solution provided]:  https://issues.jboss.org/browse/BGBUILD-289?focusedCommentId=12619627&page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#comment-12619627
[0.9.4 release blog]: http://blog/2011/08/18/boxgrinder-0-9-4-released/
[RHBZ 729340]: https://bugzilla.redhat.com/show_bug.cgi?id=729340
[CentOS 6 bug]: http://bugs.centos.org/view.php?id=4995
[alpha status]: https://fedoraproject.org/wiki/F16_Alpha_release_announcement

