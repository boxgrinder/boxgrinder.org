---
title: "BoxGrinder Build plugins"
layout: one-column
---

# Plugin introduction

There are three types of BoxGrinder plugins:

1. Operating system plugins
2. Platform plugins
3. Delivery plugins

## Operating system plugins

The goal of this kind of plugin is to create a base image for the selected operating system. Each plugin must inherit the BaseOperatingSystemPlugin class.

* Fedora plugin
* CentOS plugin
* RHEL plugin

## Platform plugins

Platform plugins convert intermediary deliverables produced by the operating system plugin into a selected platform. A platform could be VMware vSphere or Amazon EC2 for example.

* VMware plugin
* VirtualBox Plugin
* EC2 plugin

## Delivery plugins

A delivery plugin moves the deliverables from a platfrorm or operating system plugin to a selected location type. This could be a local directory, SFTP server, Amazon CloudFront or an Amazon S3 bucket.

* Local plugin
* SFTP plugin
* S3 plugin
* EBS Plugin

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

## Fedora Operating System Plugin

This plugin creates base disk image with Fedora operating system installed.

### Configuration

    plugins:
      fedora:
        format: qcow2      # Disk format to use. Default: raw.

### Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-fedora-os-plugin

* other systems

        gem install boxgrinder-build-fedora-os-plugin

### Examples

`fedora-13.appl`:

    name: fedora-13
    os:
      name: fedora
      version: 13

    [...]

### Usage

    boxgrinder build fedora-13.appl

## CentOS Operating System Plugin

This plugin creates base disk image with CentOS operating system installed.

### Configuration

    plugins:
      centos:
        format: qcow2      # Disk format to use. Default: raw.

### Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-centos-os-plugin

* other systems

        gem install boxgrinder-build-centos-os-plugin

### Examples

`centos-5.appl`:

    name: centos-5
    os:
      name: centos
      version: 5

    [...]

### Usage

    boxgrinder build centos-5.appl

## RHEL Operating System Plugin

This plugin creates base disk image with RHEL operating system installed.

### Configuration

    plugins:
      rhel:
        format: qcow2      # Disk format to use. Default: raw.

### Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-rhel-os-plugin

* other systems

        gem install boxgrinder-build-rhel-os-plugin

### Examples

`rhel-6.appl`:

    name: rhel-6
    os:
      name: rhel
      version: 6

    [...]

### Usage

    boxgrinder build rhel-6.appl

## VMware Platform Plugin

This plugin creates disk image and descriptors consumable by VMware virtualization software. There are two types of disk and virtual machine descriptors created:

1. personal,
2. enterprise.

Personal is meant to use with VMware Fusion, Player, Workstation. Enterprise should be used with VMware vSphere, ESX/i.

> Note: Read README file created along with the image before you launch it for detailed instructions

### Supported operating systems

> TODO

### Configuration

    plugins:
      vmware:
        type: personal   # or enterprise (required)
        thin_disk: true  # default: false

### Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-vmware-platform-plugin

* other systems

        gem install boxgrinder-build-vmware-platform-plugin

### Examples

    boxgrinder build jeos.appl -p vmware

## VirtualBox Platform Plugin

This plugin creates disk image and descriptors consumable by VirtualBox virtualization software. Created disk is in vmdk format, you need to import it to your library, create new virtual machine and use imported disk.

### Supported operating systems

> TODO

### Configuration

> No configuration required

### Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-virtualbox-platform-plugin

* other systems

        gem install boxgrinder-build-virtualbox-platform-plugin

### Examples

    boxgrinder build jeos.appl -p virtualbox

## EC2 Platform Plugin

This plugin creates a EC2 disk image.

> Note: Created image **isn't a bundled AMI** – it is a disk image prepared to be bundled and delivered by the S3 plugin.

### Supported operating systems

> TODO

### Configuration

> No configuration required

### Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-ec2-platform-plugin

* other systems

        gem install boxgrinder-build-ec2-platform-plugin

### Examples

    boxgrinder build jeos.appl -p ec2

## Local delivery plugin

This plugin delivers the artifacts to specified path on local filesystem.

### Supported operating systems

> TODO

### Supported platforms

> TODO

### Configuration

    plugins:
      local:
        path: /home/oddthesis/builds   # (required)
        overwrite: false               # default: false
        package: false                 # default: true

### Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-local-delivery-plugin

* other systems

        gem install boxgrinder-build-local-delivery-plugin

### Examples

VMware appliance delivered to local filesystem:

    boxgrinder build jeos.appl -p vmware -d local

VirtualBox appliance delivered to local filesystem:

    boxgrinder build jeos.appl -p virtualbox -d local

## SFTP Delivery Plugin

This plugin copies artifacts to a remote location using SFTP protocol.

### Supported operating systems

> TODO

### Supported platforms

> TODO

### Configuration

    plugins:
      sftp:
        path: /var/uploads                  # required
        username: stormgrind                # required
        host: myhost.com                    # required

### Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-sftp-delivery-plugin

* other systems

        gem install boxgrinder-build-sftp-delivery-plugin

### Examples

VMware appliance delivered to remote SFTP server:

    boxgrinder build jeos.appl -p vmware -d sftp

VirtualBox appliance delivered to remote SFTP server:

    boxgrinder build jeos.appl -p virtualbox -d sftp

## S3 Delivery Plugin

This plugin delivers artifacts to a S3 bucket. The plugin is able to deliver artifact in three types:

* **s3** - a packaged (.tgz) image with metadata - good for distribution,
* **cloudfront** - a packaged image with metadata (same as for s3 type) for public download using CloudFront - great for distribution, you need to have CloudFront enabled for your account,
* **ami** - creates an AMI from selected image and registers it in Amazon EC2. After that the AMI will be visible for you as a private image and ready to run. This type is only available for images in EC2 format (converted using "-p ec2" switch).

### Configuration

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

### Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-s3-delivery-plugin

* other systems

        gem install boxgrinder-build-s3-delivery-plugin

### Examples

EC2 AMI for `jeos.appl`:

    boxgrinder build jeos.appl -p ec2 -d ami

Packaged VirtualBox appliance delivered to CloudFront server:

    boxgrinder build jeos.appl -p virtualbox -d cloudfront

Packaged VirtualBox appliance delivered to S3 bucket:

    boxgrinder build jeos.appl -p virtualbox -d s3

## EBS Delivery Plugin

This plugin delivers appliance as EBS-based AMI to AWS.

> Note: Only appliances converted to EC2 format using EC2 platform plugin can be delivered as EBS AMI's.

> **Warning:** You can use this plugin only on instances running on EC2. This plugin will not work on your local host because we need to mount EBS volume to copy the data and we cannot do a remote mount. You can use meta appliance AMI to create EBS AMI's.

### Supported operating systems

> TODO

### Supported platforms

> TODO

### Configuration

    plugins:
      sftp:
        access_key: AWS_ACCESS_KEY                        # required
        secret_access_key: AWS_SECRET_ACCESS_KEY          # required
        account_number: AWS_ACCOUNT_NUMBER                # required
        availability_zone: us-east-1b                     # default: current region
        delete_on_termination: false                      # default: true

> Note: The delete_on_termination flag is used to specify if the root volume should be deleted after the instance is terminated.

### Installation

* Fedora/RHEL/CentOS

        yum install rubygem-boxgrinder-build-ebs-delivery-plugin

* other systems

        gem install boxgrinder-build-ebs-delivery-plugin

### Examples

EBS EC2 AMI for `jeos.appl`:

    boxgrinder build jeos.appl -p ec2 -d ebs




