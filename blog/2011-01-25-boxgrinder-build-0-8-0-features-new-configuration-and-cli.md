---
title: "BoxGrinder Build 0.8.0 features: New configuration and CLI"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder_build ]
---

With
the upcoming 0.8.0 BoxGrinder Build version we have decided to
change a bit the way of configuring and using it. The changes
affect both the configuration files and the command line interface.
Read on to learn more!
# Configuration file

While we had a global configuration file earlier but it wasn't
really exposed because the functionally was far away from worth
mentioning. But now it's changed! As you may expect, the
configuration file uses YAML format. There are some interesting
parameters you can set. Let's take a look at them. By default
BoxGrinder will look in `$HOME/.boxgrinder/config` file for
configuration data. But you can easily override it
using `BG_CONFIG_FILE` environment variable:

    export BG_CONFIG_FILE=/home/boxgrinder/boxgrinder_config_file   

## Global configuration

### Logging

You can set the log level. Choose between: info (default), warn,
error, debug and trace.

    log_level: trace    

### Cleaning a build

To remove previous build for selected appliance (other will stay
untouched) - force it!

    force: true
    
### Directories

You can adjust paths for two type of directories:

-   **root** - where everything happens: where appliance is created
    and logs are stored. By default this is set to current folder.
-   **cache** - where cached files are stored. Currently used only
    by RPM-based OS plugin and similar to store downloaded RPMs.
    Default is `/var/cache/boxgrinder`.

Example:

    dir:
      root: /home/boxgrinder/work
      cache: /home/boxgrinder/cache


### Custom plugins

If you
[wrote a BoxGrinder Build plugin](http://community.jboss.org/docs/DOC-15555)
and you want to include it - you need to tell BoxGrinder the name
of the plugin. Provide the name to BoxGrinder, and the plugin will
be registered and ready to use.

    additional_plugins:
      - some-funky-bg-plugin
      - another-great-bg-plugin
    

## Plugin configurations

But that's not everything.
**Now plugins will use this global configuration file instead of having one file per plugin.**
This will simplify configuration management. It's simple to update
your current configuration. Just copy the data form your plugin
configuration file to a section marked with the plugin name.

Let's
take a look at local delivery plugin configuration file stored in
`~/.boxgrinder/plugins/local` file:

    path: /var/boxgrinder/appliances
    package: false


This is how
you'll write in new BoxGrinder Build configuration file.

    plugins:
      local:
        path: /var/boxgrinder/appliances
        package: false    

# Command Line Interface

We have updated also BoxGrinder CLI. With move from
[commander](http://rubygems.org/gems/commander) gem to
[thor](http://rubygems.org/gems/thor) - we won **more flexibility**
on parsing user input. Take a look at built-in help command:

    $ boxgrinder help build

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
          [--platform-config=key:value]           # Platform plugin options.
      -d, [--delivery=DELIVERY]                   # The delivery method for selected appliance.
                                                  # Default: none
          [--debug]                               # Prints debug information while building. Default: false.
          [--os-config=key:value]                 # Operating system plugin options.
          [--trace]                               # Prints trace information while building. Default: false.
      -f, [--force]                               # Force image creation - removes all previous builds for selected appliance. Default: false.
          [--delivery-config=key:value]           # Delivery plugin options.
      -l, [--additional-plugins=plugin1 plugin2]  # Space separated list of additional plugins. Default: empty.
      -p, [--platform=PLATFORM]                   # The name of platform you want to convert to.
                                                  # Default: none

    Create an image from selected appliance definition for selected platform and deliver it using selected method.
    

Please notice that the
**executable was changed from boxgrinder-build to boxgrinder**!

Some options you already know, like -p or -d switches, but some are
new. Most important change is that
**you can specify plugin options using CLI from now!** Sometimes
you want to change the bucket name or other thing just for one
build. Now you can do this - overriding values specified in
configuration file.

Let's override local delivery plugin
configuration specified in above configuration file.

    $ boxgrinder build jeos.appl -p vmware -d local --platform-config type:personal thin_disk:true --delivery-config path:'/var/boxgrinder/tmp' package:true    

Now you have
the idea how it works! That's all for today. In the next article
I'll discuss another nice 0.8.0 feature: using BoxGrinder Build as
a library! If you have question or comments - feel free to join #boxgrinder channel on irc.freenode.net!