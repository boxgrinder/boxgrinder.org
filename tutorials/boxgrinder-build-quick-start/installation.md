---
title: "BoxGrinder Build installation"
layout: one-column
---

1. [Preparing environment to use BoxGrinder Build][prepare]
2. BoxGrinder Build installation
3. [Build your first appliance][build]

***

> Note: Before you install BoxGrinder make sure you have [prepared your environment][prepare] or use [meta appliance][meta].

## Install BoxGrinder Build

### Fedora 13+, RHEL/CentOS

The easiest way to obtain BoxGrinder Build is to simply add BoxGrinder repo to your environment and use yum.

> Note that admin rights might be required to run this command.

    yum install rubygem-boxgrinder-build

### Other systems

    gem install boxgrinder-build

## Install required plugins

> Please refer to [plugins page][plugins] for a full plugin list

BoxGrinder Build has a plugin architecture. Before you can build anything - you need install plugins for operating system / platform combination you want to build for. See [plugins page][plugins] for more information about the available plugins. Please consult selected plugin section on how to install this plugin.

> We don't install the plugins automatically because we don't know which plugins you'll use.

### Fedora 13+, RHEL/CentOS

> Note that admin rights might be required to run this command.

    yum install rubygem-boxgrinder-build-PLUGIN_NAME-plugin

### Other systems

    gem install boxgrinder-build-PLUGIN_NAME-plugin

Done!

After this you should be ready to use BoxGrinder Build:

    boxgrinder help

Now you can [build your appliance][build].

[meta]: /tutorials/boxgrinder-build-meta-appliance
[plugins]: /tutorials/boxgrinder-build-plugins

[prepare]: /tutorials/boxgrinder-build-quick-start/preparing-environment
[install]: /tutorials/boxgrinder-build-quick-start/installation
[build]: /tutorials/boxgrinder-build-quick-start/build-your-first-appliance

