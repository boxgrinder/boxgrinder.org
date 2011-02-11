---
title: "BoxGrinder Build 1.0.0.Beta2 and new StormFolio appliances: GateIn 3.0.0.FINAL and Fedora 11 JEOS"
author: Marek Goldmann
layout: blog
tags: [ boxgrinder, fedora, gatein, jeos, meta-appliance, stormfolio ]
---

I'm happy to announce availability of new [BoxGrinder Build](#{site.links[:build]}) version. 1.0.0.Beta2 is a bugfix release. We focused us on easy delivering of BoxGrinder Build too. From now we use RubyGems to deliver BoxGrinder Build releases -- there is no need to grab sources. For always up to date versions go to BoxGrinder Build RubyGem page. We added Fedora 12 support to BoxGrinder too, now you can build also Fedora 12 images.

If you're using Fedora (11 or 12) you can also add BoxGrinder repo to your setup and run:

    yum install rubygem-boxgrinder-build

to install BoxGrinder Build.

With new BoxGrinder Build version we released brand new **meta appliance** which is ready to build your images. You can grab it here.

BoxGrinder Build [documentation](#{site.links[:build_doc]}) was updated. Especially we added a [Quick Start](#{site.links[:build_doc]}/quick_start) page so you can start building your images as quickly as possible.

# New StormFolio appliances

Two weeks ago GateIn team released final version of GeteIn 3.0.0. GateIn is a portal project from JBoss and eXo. We provide now appliances ready to run **GateIn 3.0.0.FINAL** on your favorite virtual environment as well on EC2!

We feel there is strong demand for appliances easy to customize. Therefore we provide now a **JEOS version of Fedora**. It's Fedora 11 based, we're working to make a really good Fedora 12 image (news soon!). You can run a JEOS appliance and install necessary software. This way you can quick start with development or production environment without CD jugging.

All appliances are **ready to use**, grab them from StormFolio download page!

# Future

Now we want to work on BoxGrinder REST and deliver first Beta in the near future. Keep an eye on this blog and [Twitter](#{site.links[:twitter]}).

