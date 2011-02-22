---
title: "BoxGrinder RPM repositories"
layout: one-column
---

# BoxGrinder Build

> BoxGrinder Build is included in Fedora. If you use this operating system, please use yum to install BoxGrinder Build.

BoxGrinder Build does have two repositories:

1. **stable** - contains official released BoxGrinder RPMs
2. **nightly** - contains RPM built every night by our [Continuous Integration][ci] server from BoxGrinder Build master branch.
These packages *may be not 100% stable*.

## YUM

Below you can find instruction on how to enable these repositories in YUM.

### BoxGrinder Build stable repository

#### Fedora

    curl http://boxgrinder.org/files/yum/boxgrinder-fedora.repo > /etc/yum.repos.d/boxgrinder.repo

#### RHEL/CentOS

    curl http://boxgrinder.org/files/yum/boxgrinder-rhel.repo > /etc/yum.repos.d/boxgrinder.repo

### BoxGrinder Build nightly repository

#### Fedora

    curl http://boxgrinder.org/files/yum/boxgrinder-fedora-nightly.repo > /etc/yum.repos.d/boxgrinder.repo

#### RHEL/CentOS

    curl http://boxgrinder.org/files/yum/boxgrinder-rhel-nightly.repo > /etc/yum.repos.d/boxgrinder.repo

[ci]: http://ci.stormgrind.org/project.html?projectId=project2&tab=projectOverview&guest=1