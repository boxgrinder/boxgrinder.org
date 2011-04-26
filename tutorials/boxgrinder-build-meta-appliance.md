---
title: "BoxGrinder Build Meta appliance usage"
layout: one-column
---

The easiest way to get starting building appliances is to use the [meta appliance][meta_appliance]. It provides a complete environment for [BoxGrinder Build][bgbuild] that you can run in your favorite virtual environment without affecting your workstation. The meta appliance is based on [Fedora](http://fedoraproject.org/).

> Note: This document is a work-in-progress. You'll see text that needs clarification and expanding marked TODO: [like this].

# Downloading

The latest meta appliances for various virtual environments is available from the [meta appliance][meta_appliance] page. After downloading, follow the appropriate instructions below for booting your instance.

> TODO: [When should I use 32-bit vs 64-bit images? What about RAW vs VMware? It would be nice to show which image work with which hypervisors.]
## 32 vs 64 bit variants
BoxGrinder Meta is available in both 32 and 64 bit variants. The 64 bit versions provide the best performance and flexibility, and are recommended unless your hardware is unable to support [x86-64](http://en.wikipedia.org/wiki/X86-64). The 64 bit versions has several key advantages; 

* In excess of 4GB of RAM can be assigned to the meta appliance, and more than ~3GB is usable by a single application [^1]. 
* Building of cross-architecture 32 bit (i386, i586, i686) appliances is possible, in addition to native 64 bit build support. The 32 bit appliances are capable only of 32 bit builds only.     
* BoxGrinder Build benefits from improvements and optimisations in modern 64 bit architectures and OSes, such as increased numbers of registers, newer instruction sets and improvements in memory-mapping.

[1] Even with [PAE](http://en.wikipedia.org/wiki/Physical_Address_Extension) each application is still limited to ~3GB of virtual address space.

# Booting Locally

## VMware Fusion on Mac

1. Download the Fedora 13 32-bit meta appliance from the download page.
2. Extract the downloaded file (`boxgrinder-meta-VERSION-fedora-VERSION-i386-vmware.tgz`). This will create the directory `boxgrinder-meta-VERSION-fedora-VERSION-i386-vmware`.
3. Using VMware Fusion, choose File / Open, browse to that folder and open the boxgrinder-meta image.
4. Increase the default of 512 MB of RAM to 1024 MB (or more!) - appliances might build with less but it will take a drastically longer amount of time.
5. Login as root with password **boxgrinder**.

## VirtualBox

1. Make sure you've downloaded the **VMware tgz** bundle
2. Extract the downloaded tgz file
3. In VirtualBox, create a new Virtual Machine. Choose Linux as the Operating System and Fedora as the version.
4. Increase the default of 512 MB of RAM to 1024 MB (or more!) - appliances might build with less but it will take a drastically longer amount of time.
5. Choose "Use existing hard disk" and click the browse folder icon to open the Virtual Media Manager
6. Click the Add icon on the toolbar of the Virtual Media Manager
7. Browse to the extracted `boxgrinder-meta-personal.vmdk` file and select it, closing the Virtual Media Manager
8. Make sure `boxgrinder-meta-personal.vmdk` is displayed and click Continue on the Virtual Hard Disk screen
9. Review your hardware choices and click Done

## Booting on EC2

1. Grab latest AMI number from [meta appliance][meta_appliance] page.
2. Launch the AMI.
3. Login via SSH using the keypair you specified when launching the appliance. The username is **ec2-user**. It has full sudo access.

# That's all

See [quick start article][bgbuild_quick_start] if you want learn more on how to use BoxGrinder Build.

[bgbuild_quick_start]: /tutorials/boxgrinder-build-quick-start/
[bgbuild]: /build
[meta_appliance]: /download/boxgrinder-build-meta-appliance/
