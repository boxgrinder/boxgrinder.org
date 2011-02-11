---
title: "JBoss PaaS arrives and BoxGrinder update"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder, jboss, paas, red-hat ]
---

# JBoss PaaS

Yesterday [Red Hat](http://www.redhat.com/)
[announced in a webcast](http://www-waa-akam.thomson-webcast.net/us/dispatching/?event_id=4823cc54f791257334ecc3038e901faf&portal_id=af9b227bf07c733390c2738ee0330646)
a new PaaS solution based on JBoss and Red Hat products. You can
read more about this on
[JBoss PaaS dedicated site](http://www.jboss.com/solutions/PaaS/).
[Red Hat PaaS press release](http://www.redhat.com/about/news/prarchive/2010/PaaS.html)
contains valuable information too! We're very excited and encourage
you to look closely to JBoss PaaS.

![image](/images/rh-paas.png "Red Hat PaaS")

# BoxGrinder news

## New website!

![image](/blog/assets/boxgrinder_logo_200px.gif "BoxGrinder")Since
yesterday
[BoxGrinder has a new project page](http://jboss.org/boxgrinder)
and
[community space](http://community.jboss.org/en/boxgrinder?view=overview)!
We're very proud to see our kid standing on its own legs.
## BoxGrinder Build 0.5.1 released

With the new site we released also a new BoxGrinder version: 0.5.1.
This is mostly a bugfix release including boxgrinder-core,
boxgrinder-build and a few plugins. Here is the full list of bugs
fixed in this release:

-   [[BGBUILD-40](https://jira.jboss.org/browse/BGBUILD-40)] - Augeas kills guestfish after 'aug\_init "/" 0'
-   [[BGBUILD-43](https://jira.jboss.org/browse/BGBUILD-43)] -
    ec2-ami-tools is not usable on EC2 appliances
-   [[BGBUILD-44](https://jira.jboss.org/browse/BGBUILD-44)] -
    ExecHelper should raise exception if execution fails
-   [[BGBUILD-45](https://jira.jboss.org/browse/BGBUILD-45)] -
    system-config-securitylevel-tui package is required on RHEL/CentOS
    5

To update BoxGrinder to latest version run this command:

    gem update boxgrinder-core boxgrinder-build boxgrinder-build-rpm-based-os-plugin boxgrinder-build-fedora-os-plugin boxgrinder-build-rhel-os-plugin boxgrinder-build-centos-os-plugin boxgrinder-build-fedora-os-plugin boxgrinder-build-ec2-platform-plugin

A bit long, but
should do the work. If you have questions, we're for you in our
[new forums](http://community.jboss.org/en/boxgrinder?view=discussions).