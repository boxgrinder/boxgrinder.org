---
title: "Domain Name System - the forgotten cloud service"
author: 'Michael Neale'
layout: blog
tags: [ cooling-tower, dns ]
---

Inspired by the good folks at Rackspace (specifically,
[this post](http://www.rackspacecloud.com/blog/2009/06/04/dns-the-overlooked-cloud-service/)),
I realised how important it was to have a easily programmable DNS
api for cloud applications and services.

# Why do I need to care about DNS ?

Well, its all very well deploying your fantastic app to a fantastic
elastic cluster, but its not so fun when it has urls like

    http://somethingwierd.4324324.xyz.zw.com
    http://203.143.2.23

(I hope I haven't offended anyone by using those
addresses - there was one time Van Halen put a serial number on the
back of an album that happened to be someones phone number, so
crazed fans called the number, over and over, until Van Halen was
sued over it. But I digress). So to avoid being sued due to over
zealous Van Halen fans, you need to have a naming service: DNS. The
fabric of the internet, full of quaint terms like "bailiwick" (I
wish I wasn't making this up). For single apps, you can use either
your own DNS server(s), or use a pay for service etc (there are
many options of course). Running your own DNS is nice, it gives you
flexibility to run many apps under one domain (using subdomains for
specific apps), use it to "move" apps around whenever you need
(which is pretty common in clouds - servers can come and go, change
data centres, change IPs as you bring up a new one etc).
# A simple API

Wouldn't it be nice to have some near API to make it as simple as:

    curl -d subdomain=applicationName&amp;address=1.2.3.4 http://coolingtower/api/naming/domains/samplezone.org
    curl -d subdomain=applicationName&amp;address=somewhere.com http://coolingtower/api/naming/domains/samplezone.org

Well you would be in luck! (It is a nice rule of thumb that a
RESTful interface can be driven from the command line - the above
using the excellent curl tool - you can use anything of course).
However, DNS is full of traps for young players, and really, what
we want is to be a big Map<String, IP\> in the sky, magically
guiding browsers to the right server.
# Where and when would I use this?

Mainly for the entry points that end users will see in their
browser- but it can also be useful for internal resources like
databases, and other services that your applications consume (to
avoid binding to IPs directly). For example, imagine you have your
own cloud service, you register name for the top level domain:
**stormgrind.com**. With a DNS service you can have:

    http://demo.stormgrind.com
    http://db1.stormgrind.com
    http://www.stormgrind.com

...and so on, you get the idea.
# A RESTful API for DNS management

CoolingTower has a programmatic (RESTful) interface to manage DNS
mappings, and also an (optional) authoritative DNS server (if you
don't have one already). DNS data is stored in standard "zone
files". It will validate and store the changes in zone files - and
those changes can be propagated to the DNS servers. If you use the
EagleDNS service it will instantly pick up the changes and apply
them - applying sensible defaults, updating serial numbers, setting
short time to live values (so changes are applied quickly) - all
are done automatically to keep things easy and less error prone.
There is much more to the RESTful api, and it is being documented.
# More info and some links

-   CoolingTower naming service
    [documentation/wiki.](http://community.jboss.org/wiki/CoolingTowerNamingserviceconfigurationandusage)
-   Build/source install instructions
    [here](http://community.jboss.org/wiki/CoolingTower).
-   EagleDNS is can be obtained from
    [here](http://www.unlogic.se/projects/eagledns) (the latest release
    has my patches for automatically updating zones are they are
    changed).
