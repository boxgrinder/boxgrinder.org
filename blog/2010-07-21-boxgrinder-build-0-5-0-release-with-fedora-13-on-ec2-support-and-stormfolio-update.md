---
title: "BoxGrinder Build 0.5.0 release with Fedora 13 on EC2 support and StormFolio update"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder, fedora, gatein, jeos, stormfolio ]
---

# BoxGrinder Build 0.5.0 released!

I'm really happy to announce new BG release. Many people are waiting, so let's go into details!

# Fedora 13 support for EC2

This was a big task. Thank to guys at Amazon and Fedora/Red Hat community we make it come true. **Fedora 13 runs smoothly on EC2!** This was possible because Amazon released new [PVGrub kernel images](http://thecloudmarket.com/search?search_term=pv_grub). With that AKI's we can run our own (installed on AMI) kernel instead of forced by Amazon's. Goodbye old kernels!

This opens new possibilities for Fedora on EC2, for example there is a plan for Fedora 14+ to have official AMI's on EC2. You can see the [feature page on Fedora wiki](http://fedoraproject.org/wiki/Features/EC2). Feel free also to join [Fedora Cloud list](https://admin.fedoraproject.org/mailman/listinfo/cloud) and say what you think!

# Continuous Integration and nightly builds

We set up a Continuous Integration server for StormGrind projects (BG included!) [here](http://ci.boxgrinder.org/guestLogin.html?guest=1). You can watch if we write stable code and download latest builds!

![Artifact downloads](/images/screenshots/ci_artifact_downloads.png)

# Fresh appliances in StormFolio

Yes, we know, you want to start NOW. We prepared new, fresh appliances, among others with Fedora 13 JEOS. It's ready to run on your favorite virtualization platform. We updated also GateIn appliance to latest version (3.1.0.FINAL).

Full list of appliances is available on StormFolio dowload page.

# External plugins

We've done another major step in simplifying BoxGrinder. We removed plugins from our core repo and moved them to plugins repo. What's the big deal? From now we can release an update to a plugin (or a new plugin of course!) without pushing out new BG version. It'll speed up new features delivery and make you happy!

Every plugin, exactly like BoxGrinder itself, is released as a gem. For full list of released plugins consult this page.

How to use the new plugins you may ask? It's really simple, install boxgrinder-build gem

    gem install boxgrinder-build

and install selected plugin

    gem install boxgrinder-build-fedora-os-plugin

…and you're ready to build appliances based on Fedora OS.

In the near feature you can expect an article about writing new plugins, step-by-step, with examples. Watch the space!

# Thanks!

Thank you for using BoxGrinder and our appliances. Now, go grab the hot stuff and let us know how it works! We really need your feedback. If you're new to BoxGrinder, start with our documentation and let us know how it goes!

BoxGrinder Build JIRA is always open for issues.
/www.citytechinc.com/content/en/home.html) mobile application prepared for JBoss World / Red Hat Summit is based on CirrAS? Thanks CityTech! Read more on how it's made on [    CityTech blog post](http://blogs.citytechinc.com/jeffbrown/?p=42).