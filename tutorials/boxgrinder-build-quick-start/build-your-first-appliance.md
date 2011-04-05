---
title: "Build your first appliance with BoxGrinder Build"
layout: one-column
---

1. [Preparing environment to use BoxGrinder Build][prepare]
2. [BoxGrinder Build installation][install]
3. Build your first appliance

***

> Note: Before you start make sure you have [installed BoxGrinder Build correctly][install].

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

# Run BoxGrinder Build

The last step is to run BoxGrinder Build.

    boxgrinder-build f14-basic.appl

You can check logs located in `log/` directory if something goes wrong.

[prepare]: /tutorials/boxgrinder-build-quick-start/preparing-environment
[install]: /tutorials/boxgrinder-build-quick-start/installation
[build]: /tutorials/boxgrinder-build-quick-start/build-your-first-appliance
