---
title: "Preparing environment to use BoxGrinder Build"
layout: one-column
---

1. Preparing environment to use BoxGrinder Build
2. [BoxGrinder Build installation][install]
3. [Build your first appliance][build]

***

To start building appliances you'll need to have a proper environment. You can use the meta appliance (simple way) or prepare your own build environment (longer way).

# Meta appliance

See the meta appliance page for details on getting it up and running.

# Preparing own build environment

To build appliances using BoxGrinder you need Fedora, CentOS or RHEL operating system.

# Fedora 13+

> Info: Fedora 13 and 14 doesn't require preparing anything before installing BoxGrinder - use BoxGrinder RPMs - this will pull all required packages.

# CentOS/RHEL
## Required repositories
### EPEL

You need to add EPEL repository to your system. See EPEL installation instructions for more details.

###BoxGrinder

You need also add BoxGrinder repo placing in the `/etc/yum.repos.d/boxgrinder.repo` file this:

    curl http://repo.boxgrinder.org/boxgrinder/packages/rhel/boxgrinder.repo > /etc/yum.repos.d/boxgrinder.repo

Finished!

You're now ready to [install BoxGrinder Build][install].

[prepare]: /tutorials/boxgrinder-build-quick-start/preparing-environment
[install]: /tutorials/boxgrinder-build-quick-start/installation
[build]: /tutorials/boxgrinder-build-quick-start/build-your-first-appliance