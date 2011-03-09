---
title: "BoxGrinder Build usage instructions"
layout: one-column
---

# Main usage

After you install BoxGrinder Build you'll have `boxgrinder-build` command available. Use `--help` switch for more information:

    $ sudo boxgrinder-build --help

    Usage: boxgrinder-build [appliance definition file] [options]

    A tool for building VM images from simple definition files.

    Homepage:
        http://boxgrinder.org/

    Documentation:
        http://boxgrinder.org/tutorials/

    Examples:
        $ boxgrinder-build jeos.appl                                                           # Build KVM image for jeos.appl
        $ boxgrinder-build jeos.appl -f                                                        # Build KVM image for jeos.appl with removing previous build for this image
        $ boxgrinder-build jeos.appl --os-config format:qcow2                                  # Build KVM image for jeos.appl with a qcow2 disk
        $ boxgrinder-build jeos.appl -p vmware --platform-config type:personal,thin_disk:true  # Build VMware image for VMware Server, Player, Fusion using thin (growing) disk
        $ boxgrinder-build jeos.appl -p ec2 -d ami                                             # Build and register AMI for jeos.appl
        $ boxgrinder-build jeos.appl -p vmware -d local                                        # Build VMware image for jeos.appl and deliver it to local directory

    Options:
        -p, --platform [TYPE]            The name of platform you want to convert to.
        -d, --delivery [METHOD]          The delivery method for selected appliance.
        -f, --force                      Force image creation - removes all previous builds for selected appliance. Default: false.

    Plugin configuration options:
        -l, --plugins [PLUGINS]          Comma separated list of additional plugins. Default: empty.

            --os-config [CONFIG]         Operating system plugin configuration in format: key1:value1,key2:value2.
            --platform-config [CONFIG]   Platform plugin configuration in format: key1:value1,key2:value2.
            --delivery-config [CONFIG]   Delivery plugin configuration in format: key1:value1,key2:value2.

    Logging options:
            --debug                      Prints debug information while building. Default: false.
            --trace                      Prints trace information while building. Default: false.
        -b, --backtrace                  Prints full backtrace if errors occur whilst building. Default: true if console log is set to debug or trace, otherwise false.

    Common options:
            --help                       Show this message.
            --version                    Print the version.

## Plugin options - overriding configuration

Using CLI options you can override the configuration placed in BoxGrinder configuration file. Use `--PUGINTYPE-config` switch to set or override plugin configuration:

    $ sudo boxgrinder-build jeos.appl --os-config format:qcow2 -p vmware --platform-config disk_type:thin,type:personal -d sftp --delivery-config username:marek,path:/home/marek

You can specify one switch more than once. Above example is equivalent to this:

    $ sudo boxgrinder-build jeos.appl --os-config format:qcow2 -p vmware --platform-config disk_type:thin --platform-config type:personal -d sftp --delivery-config username:marek --delivery-config path:/home/marek

# Version information

    $ sudo boxgrinder-build --version

    BoxGrinder Build 0.9.0

    Available os plugins:
     - rhel plugin for Red Hat Enterprise Linux
     - fedora plugin for Fedora
     - centos plugin for CentOS

    Available platform plugins:
     - virtualbox plugin for VirtualBox
     - vmware plugin for VMware
     - ec2 plugin for Amazon Elastic Compute Cloud (Amazon EC2)

    Available delivery plugins:
     - ebs plugin for Elastic Block Storage
     - cloudfront plugin for Amazon Simple Storage Service (Amazon S3)
     - sftp plugin for SSH File Transfer Protocol
     - ami plugin for Amazon Simple Storage Service (Amazon S3)
     - local plugin for Local file system
     - s3 plugin for Amazon Simple Storage Service (Amazon S3)

