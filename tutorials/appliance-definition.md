---
title: "Appliance Definition"
layout: one-column
---

Appliance definition files are written in YAML. If you don't know YAML, read more [here](http://www.yaml.org), it's really easy to understand!

Let's start with a small example:

    name: httpd
    summary: Appliance with Apache HTTPD web server
    appliances:
      - jeos
    packages:
        - httpd

> Note: Only the name and os/name os/version is required. Every other section can be omitted, and defaults will be used.

# Sections

Every appliance definition file consists of one or more sections. Let's discuss them.

## name (required)

This is a name for your appliance. It must be unique in all of your appliances.

## summary

A small (one sentence or such) summary of the appliance; purpose, goals, etc.

## appliances

The appliances section is designed to reuse appliances in new definitions. For example, you can create a template for your appliances, and then create a new specialized definition with your appliance template as a dependency; it'll automatically be merged into one behind the scenes.

Example appliances section:

    appliances:
      - jeos
      - other


## packages

This section contains all of the packages you wish to add to your appliance.

Example packages section:

    packages:
      - httpd
      - mc


## repos

In this section you can specify additional repositories in order to add packages to your appliance that are sourced from these repositories.

There are two types of link:

* `mirrorlist`, and
* `baseurl`.

Notice that you can use #ARCH# tag to substitute architecture for the current building architecture, eg. if the appliance will be built on a 64 bit platform, x86_64 will be injected. In the other case i386 will be injected.

### Ephemeral repositories

By default all repositories listed in an appliance definition file are installed into the appliance. If you want to specify a repository to be used only during the install phase, and don't want to install it into the YUM config of the appliance, make it ephemeral:

    repos:
      - name: "local-repo"
        baseurl: "file:///var/repo"
        ephemeral: true

Example repos section:

    repos:
      - name: "fedora-11"
        baseurl: "http://ftp.man.poznan.pl/pub/linux/fedora/releases/11/Everything/#ARCH#/os/"
      - name: "fedora-11-updates"
        mirrorlist: "http://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f11&arch=#ARCH#"

## hardware

This section gives the ability to specify virtual hardware requirements.

Members:

* `cpus` - virtual CPU count, default: 1,
* `memory` - memory quantity in MB, default: 256,
* `partitions` - partitioning scheme with root mounts and size in GB.

Example hardware section:

    hardware:
      cpus: 2
      memory: 256
      partitions:
        /:
          size: 5
        /home:
          size: 10

> Note: Not all platforms will respect the CPU/memory values; some environments will override it.

### hardware / partitions

In `partitions` subsection you define the partition scheme. Partition **sizes are specified in gigabytes** (GB).

Example partition scheme:

    hardware:
      partitions:
        /:
          size: 5      # 5 GB
        /home:
          size: 0.5    # 0.5 GB

> There must be only one root partition with '/' mount point.

If there is no partition scheme specified, one root partition with size 1GB will be added, which is equivalent to this:

    hardware:
      partitions:
        /:
          size: 1      # 1 GB


To specify **filesystem type**, add a `type` subsection.

> Default operating system filesystem type is used when no type is specified.

    hardware:
      partitions:
        /:
          size: 5
          type: ext3   # currently supported: ext3 and ext4

> Note: Every partition specified in this section will be located on one disk.

## os

This section specifies operating system information for the appliance.

Members:

* `name` - OS name, default: fedora,
* `version` - OS version; this could be a number or string: 1, rawhide, default: 12.
* `password` - this is the root password, default: boxgrinder.


Example os section:

    os:
      name: fedora
      version: rawhide
      password: fedorarulez

## post

In this section you can execute commands after the build is finished for the selected appliance format.

The post section has subsections for each platform. If you want execute operations for the base image (this means the change you make will also be included in all other appliances based on it) use the `base` subsection.

    post:
      base:
        - "/sbin/chkconfig postgresql on"

If you want to execute different commands for different platforms, use the platform name as subsection name, like this:

    post:
      vmware:
        - "echo 'vmware' > /etc/platform"
      ec2:
        - "echo 'ec2' > /etc/platform"

> Note: If you specify commands to execute for a selected format, but you do not convert the appliance to this format - the command will be not executed.

Example post section with one command executed for the base image and one command executed for VMware appliances:

    post:
      base:
        - "/sbin/chkconfig postgresql on"
      vmware:
        - "/bin/echo 'hello vmware' > /etc/sysconfig/vmware"

# Example

    name: your-appliance
    summary: This describes your appliance
    version: 1
    release: 0
    os:
      name: fedora
      version: 14
      password: weakpassword
    hardware:
      cpus: 2
      memory: 512
      partitions:
        /:
          size: 2
    packages:
      - httpd
      - mc
    repos:
      - name: "other-repo"
        baseurl: "http://repo.yoursite.com/fedora/14/#ARCH#"

