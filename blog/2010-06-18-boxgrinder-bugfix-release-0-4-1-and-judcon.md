---
title: "BoxGrinder bugfix release: 0.4.1 and JUDCon"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder, judcon ]
---

We released today new BoxGrinder Build version that fixes [BGBUILD-24](https://jira.jboss.org/browse/BGBUILD-24). The problem was that SELinux set to enforced mode generated a kernel panic on EC2 and VMware for CentOS/RHEL images.

To update to new version run:

    gem update boxgrinder-build

# JUDCon

A friendly reminder: [JUDCon](#{site.links[:judcon]}) is coming! We (well, Bob) will be at JUDcon in Boston in a few days (21 June). Catch Bob, buy him a beer and talk about the Cloud and StormGrind!
