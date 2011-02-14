---
title: "BoxGrinder Build usage instructions"
layout: one-column
---

After you install BoxGrinder Build you'll have boxgrinder command available. Use help task for more information:

    $ sudo boxgrinder help

    BoxGrinder Build:
      A tool for building VM images from simple definition files.

    Documentation:
      http://community.jboss.org/docs/DOC-14358

    Tasks:
      boxgrinder build [appliance definition file] [options]  # Create an image from selected appliance definition for selected platform and deliver it using selected method
      boxgrinder help [TASK]                                  # Describe available tasks or one specific task
      boxgrinder info                                         # Prints out the program details

# Tasks

We introduced tasks. To get more information about build tasks run: boxgrinder help TASK.

## Build task

Build task creates the appliance.

    $ sudo boxgrinder help build

    BoxGrinder Build:
      A tool for building VM images from simple definition files.

    Documentation:
      http://community.jboss.org/docs/DOC-14358

    Examples:
      $ boxgrinder build jeos.appl                                                           # Build KVM image for jeos.appl
      $ boxgrinder build jeos.appl --os-config format:qcow2                                  # Build KVM image for jeos.appl with a qcow2 disk
      $ boxgrinder build jeos.appl -f                                                        # Build KVM image for jeos.appl with removing previous build for this image
      $ boxgrinder build jeos.appl -p ec2 -d ami                                             # Build and register AMI for jeos.appl
      $ boxgrinder build jeos.appl -p vmware --platform-config type:personal thin_disk:true  # Build VMware image for VMware Server, Player, Fusion using thin (growing) disk
      $ boxgrinder build jeos.appl -p vmware -d local                                        # Build VMware image for jeos.appl and deliver it to local directory

    Usage:
      boxgrinder build [appliance definition file] [options]

    Options:
      -l, [--additional-plugins=plugin1 plugin2]  # Space separated list of additional plugins. Default: empty.
          [--debug]                               # Prints debug information while building. Default: false.
      -f, [--force]                               # Force image creation - removes all previous builds for selected appliance. Default: false.
      -d, [--delivery=DELIVERY]                   # The delivery method for selected appliance.
                                                  # Default: none
          [--trace]                               # Prints trace information while building. Default: false.
          [--platform-config=key:value]           # Platform plugin options.
          [--os-config=key:value]                 # Operating system plugin options.
      -p, [--platform=PLATFORM]                   # The name of platform you want to convert to.
                                                  # Default: none
          [--delivery-config=key:value]           # Delivery plugin options.

    Create an image from selected appliance definition for selected platform and deliver it using selected method

### Build task options

#### Overriding configuration

Using CLI task arguments you can override the configuration placed in BoxGrinder configuration file. Use `--PUGINTYPE-config` switch to set or override plugin configuration:

    boxgrinder build jeos.appl --os-config format:qcow2 -p vmware --platform-config disk_type:thin type:personal -d sftp --delivery-config username:marek path:/home/marek

## Info task

    $ sudo boxgrinder help info

    BoxGrinder Build:
      A tool for building VM images from simple definition files.

    Documentation:
      http://community.jboss.org/docs/DOC-14358

    Usage:
      boxgrinder info

    Options:
      -p, [--plugins]  # List also available plugins. Default: false.

    Prints out the program details

