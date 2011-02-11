---
title: "How to install package group using BoxGrinder?"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder, boxgrinder_build, fedora, howto, jeos ]
---

If you want install a
specified package in an appliance – you simply add it to packages
section, like that:

    packages:
      includes:
        - bash
        - mc
        - ...


Simple. But you can do more.
[Fedora](http://fedoraproject.org/) (and
[RHEL](http://www.redhat.com/rhel/) too) has notion of groups. This
helps you install a specific group of packages to have a selected
functionality installed; for example
[GNOME Desktop](http://www.gnome.org/).
# What package groups are available?

Please use `yum grouplist` command for a full list of available
package groups. Below you can find an **incomplete** (stripped
language support packages) list of groups in Fedora 14:

    Administration Tools
    Mail Server
    Network Servers
    Ruby
    System Tools
    Authoring and Publishing
    Base
    Books and Guides
    Clustering
    DNS Name Server
    Development Libraries
    Development Tools
    Directory Server
    Dogtag Certificate System
    Editors
    Educational Software
    Electronic Lab
    Engineering and Scientific
    FTP Server
    Fedora Eclipse
    Fedora Packager
    Font design and packaging
    Fonts
    GNOME Desktop Environment
    GNOME Software Development
    Games and Entertainment
    Graphical Internet
    Graphics
    Haskell
    Input Methods
    Java
    Java Development
    KDE Software Compilation
    KDE Software Development
    LXDE
    Legacy Fonts
    Legacy Network Server
    Legacy Software Development
    MinGW cross-compiler
    Moblin Desktop Environment
    MySQL Database
    News Server
    OCaml
    Office/Productivity
    OpenOffice.org Development
    Perl Development
    PostgreSQL Database
    Server Configuration Tools
    Sound and Video
    Sugar Desktop Environment
    Text-based Internet
    Virtualization
    Web Development
    Web Server
    Window Managers
    Windows File Server
    X Software Development
    X Window System
    XFCE
    XFCE Software Development

# Core group

There is also one(?) additional group called **core**. This group
contains a minimal package set and is considered as
[JEOS](http://en.wikipedia.org/wiki/Just_enough_operating_system)
for Fedora. For Fedora 14 this group installs **192 packages**
(total list - including dependencies) which is a quite good result.
Installed packages on disk take about **500 MB**.

If you want
create JEOS for Fedora using BoxGrinder, just specify the @core
package group in packages list:

    packages:
      includes:
        - @core

We have an open issue to set @core package
group a minimal package set to install on appliances. See
[BGBUILD-89](https://jira.jboss.org/browse/BGBUILD-89) for more
info. You can of course mix the package groups with packages - feel
free to experiment!

    packages:
      includes:
        - @core
        - @XFCE
        - mc
