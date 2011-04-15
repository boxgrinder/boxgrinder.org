---
title: "Support for new Clouds is coming!"
author: 'Marek Goldmann'
layout: blog
timestamp: 2011-04-15t14:15:00.10+01:00
tags: [ boxgrinder_build, elastichosts, skalicloud, openhosting, cloudsigma, serverlove ]
---

What's good? Support for new Cloud. What's better? Support for many new Clouds!

I'm excited to share with you that **with the upcoming 0.9.1 version BoxGrinder is going to support following new Clouds**:

* [ElasticHosts](http://www.elastichosts.com/) - US, UK
* [SKALI Cloud](http://www.skalicloud.com/) - Malaysia
* [Open Hosting](http://www.openhosting.com/) - US
* [Serverlove](http://www.serverlove.com/) - UK
* [CloudSigma](http://www.cloudsigma.com/) - Switzerland

It was possible because all above listed Clouds **share the same API** for disk and server management, perfect! The
[API](http://www.elastichosts.com/cloud-hosting/api) itself is really straigthorward and makes the interaction with
services easy.

At this point I would like to **thank all Cloud providers** for their help on testing this, especially
[ElasticHosts](http://www.elastichosts.com/) guys which answered all my stupid emails, thanks!

Support for these Clouds was added as [ElasticHosts plugin](/tutorials/boxgrinder-build-plugins/#ElasticHosts_Delivery_Plugin).
Detailed usage and configuration instructions for this plugin you can find on the plugin page, but the basic usage
is as simples as:

    boxgrinder-build jeos.appl -d elastichosts

# What's happening behind the scenes?

The basic workflow is following:

1. Build the appliance in starndard way.
2. Create or re-use existing disk in the Cloud with specific size.
3. Upload the disk image created previously (in chunks, so we can retry sending failed chunks) to remote disk. Data is
of course compressed so you save time.
4. Create a new server in the Cloud with newly created disk attached to it.

After this BoxGrinder returns the name and server UUID which is ready to launch!

# Help with testing

This is immediately available from our [nightly repository](/tutorials/boxgrinder-rpm-repositories/#BoxGrinder_Build_nightly_repository).
Please grab the updated packages, test it and [let us know](/community/) how it went!

If you know any other Cloud that supports ElasticHosts API, please [let us know](/community/) too!
