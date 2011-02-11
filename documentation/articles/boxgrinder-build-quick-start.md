---
title: "BoxGrinder Build Quick start"
layout: one-column
---

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

You're now ready to install BoxGrinder Build

# BoxGrinder Build installation

Before you install BoxGrinder make sure you have prepared your environment (**not necessary for Fedora 13 and 14 if you use RPMs**) or use meta appliance.

## Install BoxGrinder Build

### Fedora 13+, RHEL/CentOS

The easiest way to obtain BoxGrinder Build is to simply add BoxGrinder repo to your environment and use yum.

> Note that admin rights might be required to run this command.

    yum install rubygem-boxgrinder-build

### Other systems

    gem install boxgrinder-build

## Install required plugins

BoxGrinder Build has a plugin architecture. Before you can build anything - you need install plugins for operating system / platform combination you want to build for. See plugins page for more information about the available plugins. Please consult selected plugin wiki page on how to install this plugin.

> We don't install the plugins automatically because we don't know which plugins you'll use.

### Fedora 13+, RHEL/CentOS

    yum install rubygem-boxgrinder-build-PLUGIN_NAME-plugin

### Other systems

    gem install boxgrinder-build-PLUGIN_NAME-plugin

Done!

After this you should be ready to use BoxGrinder Build:

    boxgrinder help

Now you should prepare an appliance definition file.

# Creating simple appliance

Let's assume we want to create a simple JEOS appliance. There are a few simple steps to follow to build your image.

## Create appliances directory (optional)

Go to the directory where you want build your appliance, and execute:

    mkdir appliances

#Create appliance definition

The next step is to create an appliance definition. In this example we want create an appliance with basic packages. Below is a sample appliance definition file. Appliance definition file structure is explained here.

Create a file `f14-basic.appl` with the following content and place it under the `appliances/` directory.

    name: f14-basic
    summary: Just Enough Operating System based on Fedora 14
    os:
      name: fedora
      version: 14
    hardware:
      partitions:
        "/":
          size: 2
    packages:
      - @core

# Run BoxGrinder

The last step is to run BoxGrinder Build.

    boxgrinder build appliances/build f14-basic.appl

You can check logs located in `log/` directory if something goes wrong. See also: The specified article was not found..