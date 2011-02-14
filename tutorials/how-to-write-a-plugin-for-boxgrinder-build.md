---
title: "How to write a plugin for BoxGrinder Build"
layout: one-column
---

> TODO: This is a DRAFT

As you know, we have three types of plugins. Learn more about plugin types on theplugin page (compulsory reading :)).

# Before you start

## Ruby and Linux

BoxGrinder, and it's plugins, are written entirely in Ruby. The deployment platform for BoxGrinder (where BoxGrinder will be installed and used) is currently only Linux; Fedora and RHEL/CentOS. We may extend the list at some point.

## One plugin == one Ruby gem

Each plugin is a standalone Ruby gem. If you're not familiar with gems, please read the RubyGems documentation to learn more about them. Each plugin needs to have a Gem specification file (.gemspec) which describes the gem and its dependencies. Later you'll see an example of such a file.

## A plugin has only one entry class

Yes, that's true. But this doesn't mean you cannot include more classes in your plugin – yes, you can! And in most cases a plugin will include many files which are not only classes (for example base descriptor files).

Every plugin needs to be registered in BoxGrinder, therefore we need to have one entry point – one class. You'll find more on how to register a plugin below.

## Think about the name

You need to find a name for your plugin. We use following convention:

* OS plugin:  boxgrinder-build-PLUGIN_NAME-os-plugin
* platform plugin:  boxgrinder-build-PLUGIN_NAME-platform-plugin
* delivery plugin:  boxgrinder-build-PLUGIN_NAME-delivery-plugin.

Please create your own convention (don't use ours!). You could, for example, use: YOUR_NAME-boxgrinder-build-PLUGIN_NAME-PLUGIN_TYPE-plugin.

> Note: The selected name will also be the gem name.

# Let's write a plugin

It's good practice to keep your work in a repository. We use GitHub to store our code, it's good, use it too!

For the purposes of this tutorial we'll walk through writing a VMware platform plugin which will prepare a disk image to be consumable by the VMware platform. You can always see the actual source code for this plugin in plugins repository.

## Create a directory structure

    mkdir -p lib/boxgrinder-build-vmware-platform-plugin spec

Use `spec/` directory to create unit tests and `lib/` to store actual plugin files.

## Write your code

### Create a skeleton

Create a skeleton file with the following code:

    require 'boxgrinder-build/plugins/base-plugin'

    class VMwarePlugin < BoxGrinder::BasePlugin
      def execute
        # PLACE YOUR CODE HERE
      end
    end

Save this file in `lib/boxgrinder-build-vmware-platform-plugin/` directory under `vmware-plugin.rb` filename (filename is free to choose).

There are two things to notice:

1. Plugin needs to extend BasePlugin class.
2. Plugin needs to have an execute method. For OS and platform plugins execute method takes no arguments. The exception is delivery plugin. If delivery plugin specifies :types while registering the plugin (see table below), it is required to specify selected type as argument to the execute method. When no :types are specified,  the execute method will be run without arguments. For example the S3 plugin has: :s3, :cloudfront and :ami types and we need to know which type we should use:

    module BoxGrinder
      class S3Plugin < BasePlugin
        def execute( type = :ami )
          case type
            when :s3
              # SNIP
            when :cloudfront
              # SNIP
            when :ami
              # SNIP
          end
        end
      end
    end


> Note: You can also extend another plugin class (for example RPMBasedOSPlugin) instead of BasePlugin.

You can create as many files as you want in a plugin. It's also recommended to test your plugins. We use RSpec for unit testing.

### Write your plugin

Now we have a skeleton, let's extend it. For this example, we shall write a platform plugin. As you know, platform plugins convert a base image created by an operating system plugin into a consumable format by a selected platform.

The execute method should contain the actual code for the plugin. For the VMware plugin we need to copy the base image created by an OS plugin to a destination directory and create descriptor files for VMware. If there are also some post operations for VMware provided in appliance definition file, we execute these operations using libguestfs.

Full source code for the VMware plugin is available here – this is the best place to make familiar with process of writing a plugin.

#### Deliverables

Every plugin has some deliverables. We can distinguish two types of deliverables: disk, and everything else.

* disk - this is the disk image. There can be only one disk image per platform created.
* other - other files shipped with the appliance. For example a virtual machine descriptor or README file for the selected platform.

Our plugin will have a few deliverables. To add a deliverable you can use the `register_deliverable` method.

    register_deliverable(
                  :disk             => "\#{@appliance_config.name}.raw",
                  :vmx_enterprise   => "\#{@appliance_config.name}-enterprise.vmx",
                  :vmdk_enterprise  => "\#{@appliance_config.name}-enterprise.vmdk",
                  :vmx_personal     => "\#{@appliance_config.name}-personal.vmx",
                  :vmdk_personal    => "\#{@appliance_config.name}-personal.vmdk",
                  :readme           => "README"
          )



A deliverable is really just a path, but ensures that it is now well known for other plugins, for example for the next plugin in the chain.
Access config and appliance config

As you may see in above code listing we accessed the @appliance_config object, and you can also access the @config object. Let me explain what's there, as both are very useful.

#### @appliance_config

This object holds all of the information provided in theappliance definition file. This information is already parsed and accessible. Use this object to get information about the appliance you're trying to build.

For example if you want to know what OS the appliance should have, use @appliance_config.os.name and @appliance_config.os.version. To access the current appliance name use @appliance_config.name. For a full reference check out the ApplianceConfig file source code.

> Note: It may also be a good idea to see ApplianceConfigHelper which parses the appliance definition file in an object.

#### Use plugin configuration

If your plugin needs some special configuration (for example login and passwords to some services) you can read them from plugin configuration. Every plugin can have a configuration in YAML format stored in BoxGrinder config file. The configuration will be accessible later via `@plugin_config` object.

The configuration is stored by default in `#{ENV['HOME']}/.boxgrinder/config` file.

For example, if you have a file in `~/.boxgrinder/config` with content like this:

    plugin:
      sftp:
        login: username
        password: abcdef
        host: http://example.com

and you want to access login, simply do it this: `@plugin_config['login']`.

#### Defaults and validation

After a plugin initialization is done, `BasePlugin` calls the `after_init` method. You can put any arbitrary code there, but it's a great place to store plugin configuration defaults and perform validation.

For instance, if you want to have login and password marked as required fields, your after_init method should look like this:

    def after_init
      validate_plugin_config( [ 'login', 'password' ])
    end

And if you also want to set a default value for host:

    def after_init
      validate_plugin_config( [ 'login', 'password' ])
      set_default_config_value( 'host', 'http://defaulthost.com' )
    end

#### Create an entry point for your plugin with plugin info

Now you have your own great plugin, but how can you register that plugin? You need to instruct BoxGrinder Build what type of plugin it is, where  the plugin class is located, and what the name of the class is.

To do this create a `lib/boxgrinder-build-vmware-platform-plugin.rb` file (yes, with the same name as the directory) with following content:

    require 'boxgrinder-build-vmware-platform-plugin/vmware-plugin'

    plugin :class => BoxGrinder::VMwarePlugin, :type => :platform, :name => :vmware, :full_name  => "VMware"

The plugin method will register your plugin in BoxGrinder with provided information. We can specify following values:

<table>
    <tr>
        <td>Option name</td>
        <td>Description</td>
        <td>Required</td>
    </tr>
    <tr>
        <td>:class</td>
        <td>The plugin class, eg. BoxGrinder::EC2Plugin</td>
        <td>yes</td>
    </tr>
    <tr>
        <td>:type</td>
        <td>The plugin type. Available options: :os, :platform, :delivery</td>
        <td>yes</td>
    </tr>
    <tr>
        <td>:name</td>
        <td>The plugin name. It must be a symbol, not a string, eg. :ec2</td>
        <td>yes</td>
    </tr>
    <tr>
        <td>:full_name</td>
        <td>The plugin name. A string containing the full plugin name, eg. "Amazon Elastic Compute Cloud (Amazon EC2)"</td>
        <td>yes</td>
    </tr>
    <tr>
        <td>:versions</td>
        <td>Required only for operating system plugins. This is a array with supported operating system versions, eg. [ '12', '13', 'rawhide' ]</td>
        <td>yes (for OS plugins)</td>
    </tr>
    <tr>
        <td>:types</td>
        <td>You can have one plugin which provides various methods to deliver (or create) different versions of the artifact. This is the name you specify after -p or -d switches using BoxGrinder.

For example we have an S3 delivery plugin. Using S3 we can deliver an artifact in three types: AMI, upload to an S3 bucket, and upload to CloudFront. It is still one system, but there are more options available in order to specify what to do with our artifact.

If you don't specify :types options, the :name option will be the only available type. But if you specify one or more :types – :name will not be used anymore.</td>
        <td>no</td>
    </tr>
</table>

### Create a gemspec file

Create a `boxgrinder-build-vmware-platform-plugin.gemspec` in root directory with following content:

    Gem::Specification.new do |s|
      s.name = %q{boxgrinder-build-vmware-platform-plugin}
      s.version = "0.0.1"

      s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
      s.authors = ["Marek Goldmann"]
      s.date = %q{2010-07-26}
      s.description = %q{BoxGrinder Build VMware Platform Plugin}
      s.email = %q{info@boxgrinder.org}
      s.extra_rdoc_files = ["CHANGELOG", "lib/boxgrinder-build-vmware-platform-plugin.rb", "lib/boxgrinder-build-vmware-platform-plugin/src/README", "lib/boxgrinder-build-vmware-platform-plugin/src/base.vmdk", "lib/boxgrinder-build-vmware-platform-plugin/src/base.vmx", "lib/boxgrinder-build-vmware-platform-plugin/vmware-plugin.rb"]
      s.files = ["CHANGELOG", "Manifest", "Rakefile", "lib/boxgrinder-build-vmware-platform-plugin.rb", "lib/boxgrinder-build-vmware-platform-plugin/src/README", "lib/boxgrinder-build-vmware-platform-plugin/src/base.vmdk", "lib/boxgrinder-build-vmware-platform-plugin/src/base.vmx", "lib/boxgrinder-build-vmware-platform-plugin/vmware-plugin.rb", "spec/vmware-plugin-spec.rb", "boxgrinder-build-vmware-platform-plugin.gemspec"]
      s.homepage = %q{http://www.jboss.org/stormgrind/projects/boxgrinder.html}
      s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Boxgrinder-build-vmware-platform-plugin"]
      s.require_paths = ["lib"]
      s.rubyforge_project = %q{BoxGrinder Build}
      s.rubygems_version = %q{1.3.6}
      s.summary = %q{VMware Platform Plugin}

      if s.respond_to? :specification_version then
        current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
        s.specification_version = 3

        if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
          s.add_runtime_dependency(%q<boxgrinder-build>, [">= 0.5.0"])
        else
          s.add_dependency(%q<boxgrinder-build>, [">= 0.5.0"])
        end
      else
        s.add_dependency(%q<boxgrinder-build>, [">= 0.5.0"])
      end
    end

> Warning: Make sure you add all dependencies!

### Build and install your gem

To build your gem run:

    gem build ./boxgrinder-build-vmware-platform-plugin.gemspec

To install:

    gem install boxgrinder-build-vmware-platform-plugin-0.0.1.gem

### Test your plugin

You have your plugin installed, but still you need to inform BoxGrinder that a new plugin is available, you can do this using --plugins (-l) switch:

    boxgrinder-build test.appl -p vmware --plugins boxgrinder-build-vmware-platform-plugin

> Note: If you want specify more than one plgin, use comma (,) to separate plugin names.

> Note: For all BoxGrinder plugins created by us you don't need to specify --plugins, we search and load them automatically if they're installed.

### Push the plugin to rubygems (optional)

If your plugin is doing what it should you can upload the plugin to RubyGems, so other people can use it too!

    gem push boxgrinder-build-vmware-plugin-0.0.1.gem

> Warning: There is no way to "unpush" a published gem (but there is a yank command which can help). But, please make sure you test your plugin and double check the version you're trying to push.

## Finished!

That's all. If you have problems, feel free to ask on our forums! If you've found a bug, please file a new ticket.