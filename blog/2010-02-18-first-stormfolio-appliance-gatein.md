---
title: "First StormFolio appliance: GateIn"
author: 'Marek Goldmann'
layout: blog
tags: [ gatein, stormfolio ]
---

Yesterday
[GateIn](http://www.jboss.org/gatein/) developers
[announced](http://blog.gatein.org/2010/02/gatein-30-cr1-is-out.html)
a new 3.0.0.CR1 version. GateIn is a result of merge of two big
projects: JBoss Portal and eXo Portal. You can read more about
GateIn on [project page](http://www.jboss.org/gatein/).

![GateIn](/images/screenshots/gatein_frontpage.png "GateIn")

Today we created first appliance for
[StormFolio](http://www.jboss.org/stormgrind/projects/stormfolio.html)
- a GateIn appliance. You can grab it from
[StormFolio appliances](http://www.jboss.org/stormgrind/downloads/stormfolio.html)
directory. As usual we're providing EC2 AMI's and RAW and VMware
images. Have a lot fun with it!

**StormFolio** is a placeholder for
all JBoss (*company*, not *product*!) appliances built for
demo/showcase purposes. We'll successively add new appliances.
Currently we're thinking about a set of
[Infinispan appliances](http://community.jboss.org/wiki/InfinispanAppliance).

Interested in **source code**? All StormFolio appliances are built
using
[BoxGrinder](http://www.jboss.org/stormgrind/projects/boxgrinder.html).
Appliance definitions are available in
[StormFolio repository](http://github.com/stormgrind/stormfolio).
Spec files for additional RPMs are located in
[stormfolio-rpm](http://github.com/stormgrind/stormfolio-rpm) repo.
We're building RPMs using
[Cantiere](http://www.jboss.org/stormgrind/projects/cantiere.html).
If you have ideas for new appliances **let us know** -
[create a ticket](https://jira.jboss.org/jira/browse/SFOLIO)!