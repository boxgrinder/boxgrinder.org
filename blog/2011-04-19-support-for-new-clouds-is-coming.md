---
title: "Support for new Clouds is coming!"
author: 'Marek Goldmann'
layout: blog
timestamp: 2011-04-19t9:30:00.10+01:00
tags: [ boxgrinder_build, elastichosts, skalicloud, openhosting, serverlove ]
---

You know what's good? Support for a new Cloud. You know what's better? Support for many new Clouds!

I'm excited to share with you that **with the upcoming 0.9.1  release [BoxGrinder](/) is going to support the following new Clouds**:

* [ElasticHosts](http://www.elastichosts.com/) - US, UK
* [SKALI Cloud](http://www.skalicloud.com/) - Malaysia
* [Open Hosting](http://www.openhosting.com/) - US
* [Serverlove](http://www.serverlove.com/) - UK

It was possible because all the above listed Clouds **share the same API** for disk and server management, perfect! The
[API](http://www.elastichosts.com/cloud-hosting/api) itself is really straightforward and makes the interaction with
services easy.

At this point I would like to **thank all the Cloud providers** for their help on testing this, especially the
[ElasticHosts](http://www.elastichosts.com/) guys which answered all my stupid emails, thanks!

Support for these Clouds was added as the [ElasticHosts plugin](/tutorials/boxgrinder-build-plugins/#ElasticHosts_Delivery_Plugin).
Detailed usage and configuration instructions for this plugin can be found on the plugin page, but the basic usage
is as simples as:

    boxgrinder-build jeos.appl -d elastichosts

# What's happening behind the scenes?

The basic workflow is:

1. Build the appliance in the normal way.
2. Create or re-use an existing disk in the Cloud with a specific size.
3. Upload the disk image created previously (in chunks, so we can retry sending failed chunks) to the remote disk. The data is
compressed to reduce the upload time.
4. Create a new server in the Cloud with the newly created disk attached to it.

After this BoxGrinder returns the name and server UUID which is ready to launch!

# Help with testing

This is immediately available from our [nightly repository](/tutorials/boxgrinder-rpm-repositories/#BoxGrinder_Build_nightly_repository).
Please grab the updated packages, test it and [let us know](/community/) how it went!

If you know any other Cloud that supports ElasticHosts API, please [let us know](/community/) too!

# Which Cloud is the right one?

BoxGrinder supports more and more Clouds. Some of them are closer to your location than others. To help you find the nearest
Cloud to you see our [supported Clouds map](/cloud-locations/). Hope you like it!

Enjoy!
