---
title: "BoxGrinder Build plugins"
layout: one-column
---

((TOC))

***

# Plugin introduction

There are three types of BoxGrinder plugins:

1. Operating system plugins
2. Platform plugins
3. Delivery plugins

## Operating system plugins

The goal of this kind of plugin is to create a base image for the selected operating system. Each plugin must inherit the BaseOperatingSystemPlugin class.

* [Fedora plugin][fedora]
* [CentOS plugin][centos]
* [RHEL plugin][rhel]

## Platform plugins

Platform plugins convert intermediary deliverables produced by the operating system plugin into a selected platform. A platform could be VMware vSphere or Amazon EC2 for example.

* [VMware plugin][vmware]
* [VirtualBox Plugin][virtualbox]
* [EC2 plugin][ec2]

## Delivery plugins

A delivery plugin moves the deliverables from a platfrorm or operating system plugin to a selected location type. This could be a local directory, SFTP server, Amazon CloudFront or an Amazon S3 bucket.

* [Local plugin][local]
* [SFTP plugin][sftp]
* [S3 plugin][s3]
* [EBS Plugin][ebs]

# Plugin configuration

Some of above plugins require additional configuration after install. Please refer to selected plugin documentation for more information on this.

If a plugin configuration is needed, please place it it BoxGrinder configuration file, by default located in `~/.boxgrinder/config`. Example configuration for vmware and local plugins:

    plugins:
      vmware:
        type: personal
        thin_disk: true
      local:
        path: /mnt/builds

# Plugins

## Operating system plugins



### Fedora Operating System Plugin

***

This plugin creates base disk image with Fedora operating system installed.

#### Fedora Operating System Plugin Configuration

    plugins:
      fedora:
        format: qcow2      # Disk format to use. Default: raw.

#### Fedora Operating System Plugin Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-fedora-os-plugin

* other systems

        gem install boxgrinder-build-fedora-os-plugin

#### Fedora Operating System Plugin Examples

`fedora-13.appl`:

    name: fedora-13
    os:
      name: fedora
      version: 13

    [...]

#### Fedora Operating System Plugin Usage

    boxgrinder build fedora-13.appl









### CentOS Operating System Plugin

***

This plugin creates base disk image with CentOS operating system installed.

#### CentOS Operating System Plugin Configuration

    plugins:
      centos:
        format: qcow2      # Disk format to use. Default: raw.

#### CentOS Operating System Plugin Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-centos-os-plugin

* other systems

        gem install boxgrinder-build-centos-os-plugin

#### CentOS Operating System Plugin Examples

`centos-5.appl`:

    name: centos-5
    os:
      name: centos
      version: 5

    [...]

#### CentOS Operating System Plugin Usage

    boxgrinder build centos-5.appl









### RHEL Operating System Plugin

***

This plugin creates base disk image with RHEL operating system installed.

#### RHEL Operating System Plugin Configuration

    plugins:
      rhel:
        format: qcow2      # Disk format to use. Default: raw.

#### RHEL Operating System Plugin Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-rhel-os-plugin

* other systems

        gem install boxgrinder-build-rhel-os-plugin

#### RHEL Operating System Plugin Examples

`rhel-6.appl`:

    name: rhel-6
    os:
      name: rhel
      version: 6

    [...]

#### RHEL Operating System Plugin Usage

    boxgrinder build rhel-6.appl





## Platform plugins





### VMware Platform Plugin

***

This plugin creates disk image and descriptors consumable by VMware virtualization software. There are two types of disk and virtual machine descriptors created:

1. personal,
2. enterprise.

Personal is meant to use with VMware Fusion, Player, Workstation. Enterprise should be used with VMware vSphere, ESX/i.

> Note: Read README file created along with the image before you launch it for detailed instructions

#### VMware Platform Plugin Supported operating systems

> TODO

#### VMware Platform Plugin Configuration

    plugins:
      vmware:
        type: personal   # or enterprise (required)
        thin_disk: true  # default: false

#### VMware Platform Plugin Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-vmware-platform-plugin

* other systems

        gem install boxgrinder-build-vmware-platform-plugin

#### VMware Platform Plugin Examples

    boxgrinder build jeos.appl -p vmware












### VirtualBox Platform Plugin

***

This plugin creates disk image and descriptors consumable by VirtualBox virtualization software. Created disk is in vmdk format, you need to import it to your library, create new virtual machine and use imported disk.

#### VirtualBox Platform Plugin Supported operating systems

> TODO

#### VirtualBox Platform Plugin Configuration

> No configuration required

#### VirtualBox Platform Plugin Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-virtualbox-platform-plugin

* other systems

        gem install boxgrinder-build-virtualbox-platform-plugin

#### VirtualBox Platform Plugin Examples

    boxgrinder build jeos.appl -p virtualbox










### EC2 Platform Plugin

***

This plugin creates a EC2 disk image.

> Note: Created image **isn't a bundled AMI** – it is a disk image prepared to be bundled and delivered by the S3 plugin.

#### EC2 Platform Plugin Supported operating systems

> TODO

#### EC2 Platform Plugin Configuration

> No configuration required

#### EC2 Platform Plugin Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-ec2-platform-plugin

* other systems

        gem install boxgrinder-build-ec2-platform-plugin

#### EC2 Platform Plugin Examples

    boxgrinder build jeos.appl -p ec2





## Delivery plugins







### Local delivery plugin

***

This plugin delivers the artifacts to specified path on local filesystem.

#### Local delivery plugin Supported operating systems

> TODO

#### Local delivery plugin Supported platforms

> TODO

#### Local delivery plugin Configuration

    plugins:
      local:
        path: /home/oddthesis/builds   # (required)
        overwrite: false               # default: false
        package: false                 # default: true

#### Local delivery plugin Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-local-delivery-plugin

* other systems

        gem install boxgrinder-build-local-delivery-plugin

#### Local delivery plugin Examples

VMware appliance delivered to local filesystem:

    boxgrinder build jeos.appl -p vmware -d local

VirtualBox appliance delivered to local filesystem:

    boxgrinder build jeos.appl -p virtualbox -d local












### SFTP Delivery Plugin

***

This plugin copies artifacts to a remote location using SFTP protocol.

#### SFTP Delivery Plugin Supported operating systems

> TODO

#### SFTP Delivery Plugin Supported platforms

> TODO

#### SFTP Delivery Plugin Configuration

    plugins:
      sftp:
        path: /var/uploads                  # required
        username: stormgrind                # required
        host: myhost.com                    # required

#### SFTP Delivery Plugin Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-sftp-delivery-plugin

* other systems

        gem install boxgrinder-build-sftp-delivery-plugin

#### SFTP Delivery Plugin Examples

VMware appliance delivered to remote SFTP server:

    boxgrinder build jeos.appl -p vmware -d sftp

VirtualBox appliance delivered to remote SFTP server:

    boxgrinder build jeos.appl -p virtualbox -d sftp











### S3 Delivery Plugin

***

This plugin delivers artifacts to a S3 bucket. The plugin is able to deliver artifact in three types:

* **s3** - a packaged (.tgz) image with metadata - good for distribution,
* **cloudfront** - a packaged image with metadata (same as for s3 type) for public download using CloudFront - great for distribution, you need to have CloudFront enabled for your account,
* **ami** - creates an AMI from selected image and registers it in Amazon EC2. After that the AMI will be visible for you as a private image and ready to run. This type is only available for images in EC2 format (converted using "-p ec2" switch).

#### S3 Delivery Plugin Configuration

    plugins:
      s3:
        access_key: AWS_ACCESS_KEY                        # (required)
        secret_access_key: AWS_SECRET_ACCESS_KEY          # (required)
        bucket: stormgrind-test                           # (required)
        account_number: 0000-0000-0000                    # (required)
        path: /images                                     # default: /
        cert_file: /home/a/cert-ABCD.pem                  # required only for ami type
        key_file: /home/a/pk-ABCD.pem                     # required only for ami type
        host: http://host:8773/services/Walrus            # default: http://s3.amazonaws.com; host used to upload AMI

#### S3 Delivery Plugin Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-s3-delivery-plugin

* other systems

        gem install boxgrinder-build-s3-delivery-plugin

#### S3 Delivery Plugin Examples

EC2 AMI for `jeos.appl`:

    boxgrinder build jeos.appl -p ec2 -d ami

Packaged VirtualBox appliance delivered to CloudFront server:

    boxgrinder build jeos.appl -p virtualbox -d cloudfront

Packaged VirtualBox appliance delivered to S3 bucket:

    boxgrinder build jeos.appl -p virtualbox -d s3












### EBS Delivery Plugin

***

This plugin delivers appliance as EBS-based AMI to AWS.

> Note: Only appliances converted to EC2 format using EC2 platform plugin can be delivered as EBS AMI's.

> **Warning:** You can use this plugin only on instances running on EC2. This plugin will not work on your local host because we need to mount EBS volume to copy the data and we cannot do a remote mount. You can use meta appliance AMI to create EBS AMI's.

#### EBS Delivery Plugin Supported operating systems

> TODO

#### EBS Delivery Plugin Supported platforms

> TODO

#### EBS Delivery Plugin Configuration

    plugins:
      ebs:
        access_key: AWS_ACCESS_KEY                        # required
        secret_access_key: AWS_SECRET_ACCESS_KEY          # required
        account_number: AWS_ACCOUNT_NUMBER                # required
        availability_zone: us-east-1b                     # default: current region
        delete_on_termination: false                      # default: true

> Note: The delete_on_termination flag is used to specify if the root volume should be deleted after the instance is terminated.

#### EBS Delivery Plugin Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-ebs-delivery-plugin

* other systems

        gem install boxgrinder-build-ebs-delivery-plugin

#### EBS Delivery Plugin Examples

EBS EC2 AMI for `jeos.appl`:

    boxgrinder build jeos.appl -p ec2 -d ebs





[fedora]: #Fedora_Operating_System_Plugin
[centos]: #CentOS_Operating_System_Plugin
[rhel]: #RHEL_Operating_System_Plugin

[vmware]: #VMware_Platform_Plugin
[virtualbox]: #VirtualBox_Platform_Plugin
[ec2]: #EC2_Platform_Plugin

[local]: #Local_delivery_plugin
[sftp]: #SFTP_Delivery_Plugin
[s3]: #S3_Delivery_Plugin
[ebs]: #EBS_Delivery_Plugin