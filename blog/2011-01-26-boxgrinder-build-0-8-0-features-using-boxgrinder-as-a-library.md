---
title: "BoxGrinder Build 0.8.0 features: Using BoxGrinder as a library"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder, boxgrinder_build, ruby ]
---

This
is the second article about the **upcoming BoxGrinder Build 0.8.0**
features. Previously I
[highlighted new configuration and CLI](/blog/boxgrinder-build-0-8-0-features-new-configuration-and-cli).
Today I'll show how easy it is to use BoxGrinder from a ruby
script.
# Background

Currently if you want to use BoxGrinder Build in a script, you are
forced to execute a shell process where you specify command line
arguments. Although this is a simple solution - it isn't very
clean. Take a look at this trivial example:

    #!/bin/env ruby
    puts "Building appliance XYZ..."
    system "boxgrinder build xyz.appl -p vmware -d local"
    puts "Done!"


There are a couple of disadvantages
to this solution:

1.  **Logging** - catching STDOUT and STDERR logs from a process
    and redirecting them to our logger is painful and unreliable. We
    also lose access to any log levels that are just written to
    BoxGrinder's log.
2.  Firing up another process, well, **sucks**.

# Work log

Work on this issue was divided in to two tasks:

1.  Generally allow to use it as a library:
    [BGBUILD-79](https://issues.jboss.org/browse/BGBUILD-79),
2.  Don't require to use file-based appliance definition files:
    [BGBUILD-127](https://issues.jboss.org/browse/BGBUILD-127).

The first task was quite easy to accomplish. The second was a bit
tricky as I wanted to have **exactly the same entry point** for
file- and string-based definitions.
# Result

## Appliance definition stored in a file

Consider the following:

    #!/bin/env ruby
    require 'rubygems'
    require 'boxgrinder-build'

    log = BoxGrinder::LogHelper.new(:level => :trace)
    log.info "Building appliance XYZ..."

    begin
      BoxGrinder::Appliance.new('xyz.appl', BoxGrinder::Config.new(:platform => :vmware, :deelivery => :local), :log => log).create
      log.info "Done!"
    rescue => e
      log.error e
      log.error "Appliance build failed!"
    end


**As you can see we create an Appliance object and execute create method on it. Easy, right?**

We also create a Config object where we specify what platform we
want to use (:platform), whether we want to remove previous builds
(:force) or other parameters. For a full list of parameters, see
the
[Config class source code](https://github.com/boxgrinder/boxgrinder-core/blob/master/lib/boxgrinder-core/models/config.rb).

We also inject a logger. You are free to **use your own logger** of
course! The logger must respond to info, warn, error, debug and
**trace** methods. For more info, please take a look at our
[LogHelper](https://github.com/boxgrinder/boxgrinder-core/blob/master/lib/boxgrinder-core/helpers/log-helper.rb).
## Appliance definition stored in an object

If you need to dynamically build the appliance definition, you can
pass it as a YAML string instead of writing it to a file:

    #!/bin/env ruby
    require 'rubygems'
    require 'boxgrinder-build'

    appliance = {'name' => 'xyz', 'hardware' => {'partitions' => {'/' => {'size' => 5}}}, 'os' => {'name' => 'fedora', 'version' => 14}, 'packages' => ['mc', 'openssh-clients', 'postgresql-server']}

    log = BoxGrinder::LogHelper.new(:level => :trace)
    log.info "Building appliance XYZ..."

    begin
      BoxGrinder::Appliance.new(appliance.to_yaml, BoxGrinder::Config.new(:platform => :vmware, :deelivery => :local), :log => log).create
      log.info "Done!"
    rescue => e
      log.error e
      log.error "Appliance build failed!"
    end
    

# Conclusion

The upcoming BoxGrinder Build 0.8.0 will greatly simplify and
empower interaction between your Ruby code and BoxGrinder. But if
you're not satisfied with the details - feel free to
[create an issue](https://issues.jboss.org/browse/BGBUILD)!