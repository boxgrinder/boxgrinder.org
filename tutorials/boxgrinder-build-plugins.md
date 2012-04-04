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
* [Scientific Linux plugin][sl]

## Platform plugins

Platform plugins convert intermediary deliverables produced by the operating system plugin into a selected platform. A platform could be VMware vSphere or Amazon EC2 for example.

* [VMware plugin][vmware]
* [VirtualBox Plugin][virtualbox]
* [VirtualPC Plugin][virtualpc]
* [EC2 plugin][ec2]

## Delivery plugins

A delivery plugin moves the deliverables from a platfrorm or operating system plugin to a selected location type. This could be a local directory, SFTP server, Amazon CloudFront or an Amazon S3 bucket.

* [Local plugin][local]
* [SFTP plugin][sftp]
* [S3 plugin][s3]
* [EBS Plugin][ebs]
* [ElasticHosts plugin][elastichosts]
* [OpenStack plugin][openstack]

# Plugin configuration

Some of above plugins require additional configuration after install. Please refer to selected plugin documentation for more information on this.

If a plugin configuration is needed, please place it it BoxGrinder configuration file, by default located in `~/.boxgrinder/config`. Example configuration for vmware and local plugins:

    plugins:
      vmware:
        type: personal
        thin_disk: true
      local:
        path: /mnt/builds

Contrast this with the command-line version of the same configuration, noting that we must indicate which stage in the build pipeline our configuration options belong to:

    boxgrinder-build jeos.appl -p vmware -d local --platform-config type:personal,thin_disk:true --delivery-config path:/mnt/builds
    
> Settings within the config file are merged with any arguments provided on the command-line.  Command-line arguments take precedence over conflicting conf file options.     

# Plugins

## Operating system plugins



### Fedora Operating System Plugin

***

This plugin creates base disk image with Fedora operating system installed.

#### Fedora Operating System Plugin Configuration

    plugins:
      fedora:
        format: qcow2      # Disk format to use. Default: raw.

#### Fedora Operating System Plugin Examples

`fedora-15.appl`:

    name: fedora-15
    os:
      name: fedora
      version: 15

    [...]

#### Fedora Operating System Plugin Usage

    boxgrinder-build fedora-15.appl









### CentOS Operating System Plugin

***

This plugin creates base disk image with CentOS operating system installed.

#### CentOS Operating System Plugin Configuration

    plugins:
      centos:
        format: qcow2      # Disk format to use. Default: raw.

#### CentOS Operating System Plugin Examples

`centos-5.appl`:

    name: centos-5
    os:
      name: centos
      version: 5

    [...]

#### CentOS Operating System Plugin Usage

    boxgrinder-build centos-5.appl









### RHEL Operating System Plugin

***

This plugin creates base disk image with RHEL operating system installed.

#### RHEL Operating System Plugin Configuration

    plugins:
      rhel:
        format: qcow2      # Disk format to use. Default: raw.

#### RHEL Operating System Plugin Examples

`rhel-6.appl`:

    name: rhel-6
    os:
      name: rhel
      version: 6

    [...]

#### RHEL Operating System Plugin Usage

    boxgrinder-build rhel-6.appl





### Scientific Linux Operating System Plugin

***

This plugin creates base disk image with Scientific Linux operating system installed.

#### Scientific Linux Operating System Plugin Configuration

    plugins:
      sl:
        format: qcow2      # Disk format to use. Default: raw.

#### Scientific Linux Operating System Plugin Examples

`sl-6.appl`:

    name: sl-6
    os:
      name: sl
      version: 6

    [...]

#### Scientific Linux Operating System Plugin Usage

    boxgrinder-build sl-6.appl






## Platform plugins





### VMware Platform Plugin

***

This plugin creates disk image and descriptors consumable by VMware virtualization software. There are two types of disk and virtual machine descriptors:

1. personal
2. enterprise

Personal is meant to use with VMware Fusion, Player, Workstation. Enterprise should be used with VMware vSphere, ESX/i.

> Note: Read README file created along with the image before you launch it for detailed instructions

#### VMware Platform Plugin Supported operating systems

* Fedora - all versions
* RHEL - all versions
* CentOS - all versions

#### VMware Platform Plugin Configuration

    plugins:
      vmware:
        type: personal   # or enterprise (required)
        thin_disk: true  # default: false

#### VMware Platform Plugin Examples

    boxgrinder-build jeos.appl -p vmware








### VirtualPC Platform Plugin

Added in BoxGrinder **0.10.0**

***

This plugin creates a VHD disk image that can be used by VirtualPC or Citrix XenServer.

#### VirtualPC Platform Plugin Supported operating systems

* All operating systems

#### VrtualPC Platform Plugin Configuration

> No configuration required

#### VirtualPC Platform Plugin Examples

    boxgrinder-build jeos.appl -p virtualpc








### VirtualBox Platform Plugin

***

This plugin creates disk image and descriptors consumable by VirtualBox virtualization software. Created disk is in vmdk format, you need to import it to your library, create new virtual machine and use imported disk.

#### VirtualBox Platform Plugin Supported operating systems

* All operating systems

#### VirtualBox Platform Plugin Configuration

> No configuration required

#### VirtualBox Platform Plugin Examples

    boxgrinder-build jeos.appl -p virtualbox










### EC2 Platform Plugin

***

This plugin creates a EC2 disk image.

> Note: Created image **isn't a bundled AMI** – it is a disk image prepared to be bundled and delivered by the S3 plugin.

#### EC2 Platform Plugin Supported operating systems

* Fedora - all versions
* RHEL - all versions
* CentOS - all versions

#### EC2 Platform Plugin Configuration

> No configuration required

#### EC2 Platform Plugin Examples

    boxgrinder-build jeos.appl -p ec2





## Delivery plugins







### Local delivery plugin

***

This plugin delivers the artifacts to specified path on local filesystem.

#### Local delivery plugin Supported operating systems

* Fedora - all versions
* RHEL - all versions
* CentOS - all versions

#### Local delivery plugin Supported platforms

All platforms.

#### Local delivery plugin Configuration

    plugins:
      local:
        path: /home/oddthesis/builds   # (required)
        overwrite: false               # default: false
        package: false                 # default: true

#### Local delivery plugin Examples

VMware appliance delivered to local filesystem:

    boxgrinder-build jeos.appl -p vmware -d local

VirtualBox appliance delivered to local filesystem:

    boxgrinder-build jeos.appl -p virtualbox -d local












### SFTP Delivery Plugin

***

This plugin copies artifacts to a remote location using SFTP protocol.

#### SFTP Delivery Plugin Supported operating systems

* Fedora - all versions
* RHEL - all versions
* CentOS - all versions

 #### SFTP Delivery Plugin Supported platforms

All platforms.

#### SFTP Delivery Plugin Configuration

    plugins:
      sftp:
        path: /var/uploads                  # required
        username: stormgrind                # required
        host: myhost.com                    # required

#### SFTP Delivery Plugin Examples

VMware appliance delivered to remote SFTP server:

    boxgrinder-build jeos.appl -p vmware -d sftp

VirtualBox appliance delivered to remote SFTP server:

    boxgrinder-build jeos.appl -p virtualbox -d sftp











### S3 Delivery Plugin

***

This plugin delivers artifacts to a S3 bucket. The plugin is able to deliver artifact in three types:

* **s3** - a packaged (.tgz) image with metadata - good for distribution,
* **cloudfront** - a packaged image with metadata (same as for s3 type) for public download using CloudFront - great for distribution, you need to have CloudFront enabled for your account,
* **ami** - creates an AMI from selected image and registers it in Amazon EC2. After that the AMI will be visible for you as a private image and ready to run. This type is only available for images in EC2 format (converted using "-p ec2" switch).

#### S3 Delivery Plugin supported operating systems

* Fedora - all versions
* RHEL - all versions
* CentOS - all versions

#### S3 Delivery Plugin Supported platforms

* EC2

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
        region: us-east-1                                 # amazon region to upload and register amis in; default: us-east-1
        snapshot: true                                    # default: false
        overwrite: false                                  # default: false

#### S3 Delivery Plugin Examples

EC2 AMI for `jeos.appl`:

    boxgrinder-build jeos.appl -p ec2 -d ami
    
EC2 AMI for `jeos.appl` in `ap-southeast-1` [region](http://aws.amazon.com/articles/3912)

    boxgrinder-build jeos.appl -p ec2 -d ami --delivery-config region:ap-southeast-1    

Packaged VirtualBox appliance delivered to CloudFront server:

    boxgrinder-build jeos.appl -p virtualbox -d cloudfront

Packaged VirtualBox appliance delivered to S3 bucket:

    boxgrinder-build jeos.appl -p virtualbox -d s3
    
Use overwrite to delete the existing resource with the same name.  This works with AMI, S3 and EBS.

    boxgrinder-build jeos.appl -d ec2 --delivery-config overwrite:true

You can use overwrite with snapshot, this will overwrite only the _last_ snapshot delivered

    boxgrinder-build jeos.appl -p ec2 -d s3 --delivery-config snapshot:true,overwrite:true

If you enable snapshotted delivery, each version delivered version will have an incremented snapshot number to guarantee naming uniqueness.

    boxgrinder-build jeos.appl -p ec2 -d ami --delivery-config snapshot:true








### EBS Delivery Plugin

***

This plugin delivers appliance as EBS-based AMI to AWS.

> Note: Only appliances converted to EC2 format using EC2 platform plugin can be delivered as EBS AMI's.

> **Warning:** You can use this plugin only on instances running on EC2. This plugin will not work on your local host because we need to mount EBS volume to copy the data and we cannot do a remote mount. You can use meta appliance AMI to create EBS AMI's.

#### EBS Delivery Plugin supported operating systems

* Fedora - all versions
* RHEL - 6

#### EBS Delivery Plugin Supported platforms

* EC2

#### EBS Delivery Plugin Configuration

    plugins:
      ebs:
        access_key: AWS_ACCESS_KEY                        # required
        secret_access_key: AWS_SECRET_ACCESS_KEY          # required
        account_number: AWS_ACCOUNT_NUMBER                # required
        delete_on_termination: false                      # default: true
        availability_zone:                                # default: current availability zone
        snapshot: true                                    # default: false
        overwrite: false                                  # default: false
        terminate_instances: false                        # default: false 
        preserve_snapshots: false                         # default: false
	
	
> Note: The delete\_on\_termination flag is used to specify if the root volume should be deleted after the instance is terminated.

#### Region and Availability Zone
The plugin will automatically detect which region you are in, you do not need to provide it manually.  In fact, is not technically possible to deliver an EBS AMI to any other region than that which it is being built in.

You can, however, specify an [availability zone](http://aws.amazon.com/articles/3912) if you wish. 


#### EBS overwrite behaviour

1.  Live instances of the EBS AMI to be overwritten are discovered. By default, if any are returned, an error will be raised advising you to preserve any instance data then terminate the instances. You can set *terminate_instances: true* in your EBS config to instruct the EBS plug-in to terminate these instances on your behalf. Remember that terminating an instance will delete any attached EBS volumes<sup>[1]</sup>. If you desire to preserve a particular EBS volume
before overwriting, just detach it.

2. The AMI is de-registered. This enables the name to be reused.

3. The snapshot used to initialise all instances of the EBS AMI is located. By default this is then deleted, but you can set *preserve_snapshots: true* in your EBS config if you have some reason to retain it.

At the end of this process the original EBS AMI should be gone - with some components still surviving for you to dissect depending on your config. A new version of EBS AMI with an identical name is then built and registered as usual. 

[1] Unless you set _delete_on_termination:false_ for the appliance root, or any other EBS devices that you may have attached, in which case they will become orphaned. 

#### EBS Delivery Plugin Examples

EBS-based AMI for `jeos.appl`:

    boxgrinder-build jeos.appl -p ec2 -d ebs

This will destroy the existing `jeos.appl` EBS AMI of the same version and release. If *any instances are still running, the process will halt* before any destructive actions occur:

    boxgrinder-build jeos.appl -p ec2 -d ebs --delivery-config overwrite:true

This will destroy the existing `jeos.appl` EBS AMI of the same version and release, but *any running instances of my.appl will be terminated*:

    boxgrinder-build my.appl -p ec2 -d ebs --delivery-config overwrite:true,destroy_instances:true

Overwrite any previous EBS AMI of the same name, version and release as specified in `jeos.appl`, but *preserve any snapshot* associated with the previous build:

    boxgrinder-build jeos.appl -p ec2 -d ebs --delivery-config overwrite:true,preserve_snapshots:true


### ElasticHosts Delivery Plugin

Added in BoxGrinder **0.9.1**

***

This plugin delivers an appliance to [ElasticHosts](http://www.elastichosts.com/) Cloud. It can be used for any Cloud using the ElasticHosts API, such as [SKALI Cloud](http://www.skalicloud.com/), [Open Hosting](http://www.openhosting.com/), [Serverlove](http://www.serverlove.com/) and [CloudSigma](http://www.cloudsigma.com/).

> Note: Only base appliances (output of [Operating System plugins][os_plugins]) can be used by this plugin.

#### ElasticHosts Delivery Plugin supported operating systems

All operating systems are supported.

#### ElasticHosts Delivery Plugin Supported platforms

* See above note.

#### ElasticHosts Delivery Plugin Configuration

    plugins:
      elastichosts:
        endpoint: api.lon-p.elastichosts.com              # required
        username: your-user-id                            # required
        password: your-secret-access-key                  # required
        chunk: 128                                        # default: 64 (in MB)
        start_part: 6                                     # default: 0
        wait: 30                                          # default: 5 (in s)
        retry: 2                                          # default: 3
        ssl: true                                         # default: false
        drive_uuid: b161fd8b-d56s-4eea-9055-669daaec8aa4  # optional
        drive_name: my-bg-drive                           # optional

> Note: `username` parameter is often referred to as  *User UUID*, wheras `password` is usually *Secret API Key*. For CloudSigma specify your e-mail address and password instead of UUID/key combination.

The appliance is **uploaded in chunks**. By default we set the chunk size to 64 MB; you can change this setting with the `chunk` property.

If the plugin encounters any errors while uploading the image it retries the operation up to **three times** (set the `retry` property to adjust, set 0 to disable) starting with the failed chunk. You can use the `wait` property (in seconds) to adjust the time between retries (default: 5). If it still fails you can try to execute the BoxGrinder Build command specifying the chunk to start with using the `start_part` property (default: 0). See examples below.

By default a new remote drive will be created with the name of appliance as the default name. The name is adjustable with `drive_name` property. You may also upload the appliance to an existing drive. In this case you specify the drive UUID as `drive_uuid`. Note that if you specify both `drive_uuid` and `drive_name` the latter will be ignored.

Set `ssl` to true if you want establish a secure SSL connection to the server.

#### ElasticHosts Delivery Plugin Examples

Standard delivery for a sample JEOS appliance:

    boxgrinder-build jeos.appl -d elastichosts

Start delivery with the 6th chunk:

    boxgrinder-build jeos.appl -d elastichosts --delivery-config start_part:6

Use an already existing disk:

    boxgrinder-build jeos.appl -d elastichosts --delivery-config chunk:128,disk_uuid:b161fd8b-d56s-4eea-9055-669daaec8aa4











### OpenStack Delivery Plugin

Added in BoxGrinder **0.10.0 as a tech-preview**

***

This plugin delivers an appliance to [OpenStack](http://openstack.org/). This plugin will upload and register the appliance in specific format in [Glance](http://glance.openstack.org/) using the Glance REST API.

#### OpenStack Delivery Plugin supported operating systems

All operating systems are supported.

#### OpenStack Delivery Plugin Supported platforms

* EC2
* VMware
* VirtualBox

#### OpenStack Delivery Plugin Configuration

    plugins:
      openstack:
        host: 10.1.0.1          # default: localhost
        port: 9292              # default: 9292
        schema: http            # default: http
        overwrite: true         # default: false
        public: true            # default: false

#### OpenStack Delivery Plugin Examples

Standard delivery for a sample JEOS appliance:

    boxgrinder-build jeos.appl -d openstack

Delivery to a different host:

    boxgrinder-build jeos.appl -d openstack --delivery-config host:nightmare

Delivery of a VMware image:

    boxgrinder-build jeos.appl -p vmware -d openstack

Delivery of an EC2 image:

    boxgrinder-build jeos.appl -p ec2 -d openstack







### libvirt Delivery Plugin

Added in BoxGrinder **0.10.0 as a tech-preview**

***

This plugin delivers and registers appliances to a machine running [libvirt](http://wiki.libvirt.org/page/FAQ#What_is_libvirt.3F). Libvirt is a virtualisation API providing a hypervisor-agnostic remotevirtualisation management service; with support for a huge number of [hypervisors](http://libvirt.org/drivers.html), and a variety of secure [communication protocols](http://libvirt.org/remote.html).     
#### libvirt supported operating systems

All operating systems are supported.

#### libvirt Delivery Plugin Configuration

***connection_uri (String)*** — Libvirt endpoint address. If you are using authenticated transport such as ssh you should register your keys with an ssh agent. See: [libvirt Connection URIs](http://libvirt.org/uri.html), and [libvirt Drivers](http://libvirt.org/drivers.html).
    # Default: '' - Default empty string, libvirt decides which hypervisor to choose. 
    connection_uri: qemu+ssh://user@example.com/system 
    connection_uri: qemu:///system

***image_delivery_uri (String)*** — Where to deliver the image to. This must be a local path or an SFTP address. The local ssh-agent is used for keys if available.
    # Default: /var/lib/libvirt/images 
    image_delivery_uri: sftp://user@example.com/some/path 
    image_delivery_uri: sftp://user:pass@example.com/some/path # It is advisable to use keys with ssh-agent.

***libvirt_image_uri (String)*** — Where the image will be on the Libvirt machine.
    # Default: Path element of *image_delivery_uri*.
    libvirt_image_uri: /some/other/place # For most leaving the default will be desired behaviour.

***default_permissions (Int)*** — Permissions of delivered image.
    # Default: 0770
    default_permissions: 0755
    default_permissions: 0775
   
***overwrite (Int)*** — Overwrite any identically named file at the delivery path. Also undefines any existing domain of the same name.
    # Default: false
    overwrite: true
    
***script (String)*** — Path to user provided script to modify XML before registration with Libvirt. Plugin passes the raw XML after flag --domain, and consumes stdout to use as revised XML document.
    # Default: none
    script: /some/script.sh 
    script: /some/script.rb

***remote_no_verify (Bool)*** — Disable certificate verification procedures.
    # Default: true - This is what most people will want.
    remote_no_verify: false

***xml_only (Bool)*** — Do not connect to the Libvirt hypervisor, just assume sensible defaults where no user values are provided, and produce the XML domain.
    # Default: false
    xml_only: true
    
***appliance_name (String)*** — Name for the appliance to be registered as in Libvirt. At present the user can only specify literal strings.
    # Default: name-version-release-os_name-os_version-arch-platform
    appliance_name: boxgrinder-f16-rocks

***domain_type (String)*** — Libvirt domain type. Default is a calculated value. Unless you are using xml_only the remote instance will be contacted and an attempt to determine the best value will be made. If xml_only is set then a safe pre-determined default is used. User-set values take precedence. Owing to limitations in the library being used to discover hypervisor characteristics, in some cases KVM-capable CPUs may not be detected as such, with the result that the slower QEMU driver will be used. In this situation, users can override the auto-detected value and set it to KVM as shown in the example below. See type: [Domain format](http://libvirt.org/formatdomain.html#elements).
    # Default: calculated value, as described above
    # Examples:
    domain_type: kvm
    domain_type: qemu
    domain_type: vbox
    
***virt_type (String)*** — Libvirt virt type. Default is a calculated value. Where available paravirtual is preferred. See type: [BIOS bootloader](http://libvirt.org/formatdomain.html#elementsOSBIOS).
    # Default: calculated value, as described above.  
    # Examples:
    virt_type: hvm
    virt_type: xen
    virt_type: linux

***bus (String)*** — Disk bus. Default is a pre-determined value depending on the domain type. User-set values take precedence.
    # Default: precalculated value, as described above.
    # Examples:
    virt_type: virtio
    virt_type: ide

***network (String)*** — Network name. If you require a more complex setup than a simple network name, then you should create and set a script.
    # Default: default
    network: my_network


#### libvirt Example Configurations
There are a large number of configuration options available, but usually only a couple are needed for most requirements.

    plugins:
       libvirt:
         libvirt_uri: qemu:///system                 # See http://libvirt.org/drivers.html
         image_delivery_uri: /var/lib/libvirt/images # Where to deliver the appliance
         overwrite: true                             # Undefine any existing domain and file of the same name 
> There are *no* required parameters, but most users will want to set at least _libvirt_uri_. 
    
    plugins:
      libvirt:
        libvirt_uri: kvm+ssh://root@example.org/                           # Connect to KVM hypervisor over SSH
        image_delivery_uri: sftp://root@example.org/var/lib/libvirt/images # Only SFTP is supported for remote delivery at present
        overwrite: true                                                    # Undefine any existing domain and file of the same name 
> BoxGrinder will use your *ssh-agent* to perform key authentication for libvirt and SFTP if available.


#### Running the libvirt plugin

Deliver to local machine, register on VirtualBox hypervisor.

    boxgrinder-build example.appl -d libvirt --delivery-config libvirt_uri:vbox:///session,image_delivery_uri:/my/libvirt/images/directory

Deliver via SFTP to remote machine at `example.org`, registering on remote QEMU hypervisor tunnelled via SSH, overwrite any existing files/domains:

    boxgrinder-build example.appl -d libvirt --delivery-config libvirt_uri:qemu+ssh://example.org/system,image_delivery_uri:sftp://example.org/var/lib/libvirt/images,overwrite:true

[os_plugins]: #Operating_system_plugins

[fedora]: #Fedora_Operating_System_Plugin
[centos]: #CentOS_Operating_System_Plugin
[rhel]: #RHEL_Operating_System_Plugin
[sl]: #Scientific_Linux_Operating_System_Plugin

[vmware]: #VMware_Platform_Plugin
[virtualbox]: #VirtualBox_Platform_Plugin
[virtualpc]: #VirtualPC_Platform_Plugin
[ec2]: #EC2_Platform_Plugin

[local]: #Local_delivery_plugin
[sftp]: #SFTP_Delivery_Plugin
[s3]: #S3_Delivery_Plugin
[ebs]: #EBS_Delivery_Plugin
[elastichosts]: #ElasticHosts_Delivery_Plugin
[openstack]: #OpenStack_Delivery_Plugin
[libvirt]: #Libvirt_Delivery_Plugin
