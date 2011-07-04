---
title: 'How we test BoxGrinder'
author: 'Marek Goldmann'
layout: blog
timestamp: 2011-07-04t19:41:00.10+01:00
tags: [ ci ]
---

In this post I would like to highight our efforts to make BoxGrinder stable. It'll be about testing, of course.

# Unit tests

Our first line of defense are unit tests. Because BoxGrinder is written in Ruby we use the lovely [RSpec](http://rspec.info/) library to write our *[specs](https://github.com/boxgrinder/boxgrinder-build/tree/master/spec)*. RSpec provides a nice looking and flexible DSL for writing unit tests.

Consider following code:

    it "should add ec2-user account" do
      guestfs = mock("guestfs")

      guestfs.should_receive(:sh).with("useradd ec2-user")
      guestfs.should_receive(:sh).with("echo -e 'ec2-user\tALL=(ALL)\tNOPASSWD: ALL' >> /etc/sudoers")

      @plugin.add_ec2_user(guestfs)
    end

The code is self-explaining and that's what counts!

Currently we have over 270 tests (**[>83% C0 code coverage](http://ci.boxgrinder.org/viewLog.html?buildId=lastSuccessful&buildTypeId=bt2&tab=RCov_Report&guest=1)**) for boxgrinder-build and over 70 tests (**[>89% C0 code coverage](http://ci.boxgrinder.org/viewLog.html?buildId=lastSuccessful&buildTypeId=bt3&tab=RCov_Report&guest=1)**) for boxgrinder-core gems. And we will have more. I promise you this.

![TeamCity](/images/screenshots/teamcity.png "TeamCity CI")

As we have a [Continuous Integration](http://ci.boxgrinder.org/project.html?projectId=project2&tab=projectOverview&guest=1) server - we build our unit tests for every commit and developers are automatically notified in case of failures, triggering an immediate developer response. Most of our failed unit tests are issues with forgetting to commit something, or similar. So, not too bad.

# Integration tests

This is pretty new for us. How to do integration testing for an appliance builder? Well, we **can build** appliances! But how do we make them easy to write (and maintain)? This is another story. Thankfully BoxGrinder Build has a great feature - **you can use BoxGrinder as a library in your Ruby scripts**. You don't need to use the command line to run the builds. We [described the feature in detail earlier](/blog/2011/01/26/boxgrinder-build-0-8-0-features-using-boxgrinder-as-a-library/).

We prepared some [test appliance definitions](https://github.com/boxgrinder/boxgrinder-build/tree/master/integ/appliances).

At this time we have JEOS appliances for Fedora 15 and CentOS 5. Additionally we have a full modular appliance definitions where we have split the [appliance definition sections](/tutorials/appliance-definition/) into files and include them next. This gives us the chance to test all section plus inclusion and override functionality.

## Integration tests execution process

We cannot just *execute* the tests. There a process. And yes - we use the Cloud ([AWS](http://aws.amazon.com/) in our case). Let's take a look at all stages.

### 1. Build RPMs

Each day we create RPM's for our gems - these are our nightly builds which are also [accessible using YUM](/tutorials/boxgrinder-rpm-repositories/). We will use them later.

### 2. Start new EC2 build instance

After the RPMs are created we start a new instance on EC2. This is a feature of our continuous integration system - [TeamCity](http://www.jetbrains.com/teamcity/). If you haven't looked at TeamCity so far - I strongly recommend it. It is very powerful, looks great and it's free!

But back to our instance. After the instance is launched, and the agent installed on the instance connects to our CI server, an additional build machine in the Cloud becomes available for use.

### 3. Prepare instance

Before the build can be triggered we need to prepare the instance. We need to install BoxGrinder Build using, of course, the nightly builds created for us just a few minutes ago. Additionally we create a BoxGrinder configuration file with the required data.

Now we have launched and configured instance, let's start the tests!

### 4. Execute actual tests

This is the most important step - the agent installed on the instance pulls the latest integration tests and executes them. They look really simple, for example building Fedora JEOS may look like this:

    it "should build Fedora JEOS" do
      @appliance = Appliance.new("#{File.dirname(__FILE__)}/../appliances/jeos-fedora.appl", @config, :log => @log).create
    end

Isn't it neat? We have also set some callbacks to make sure the deliverables were created:

    after(:each) do
      @appliance.plugin_chain.last[:plugin].deliverables.each_value do |file|
        File.exists?(file).should == true
      end
    end

### 5. Save the artifacts

Every artifact created by our integration tests is saved on [CloudFront](http://aws.amazon.com/cloudfront/). This makes is easy to test the image manually later if we need to.

## What could make integration tests even more powerful?

Quick answer: [ligbuestfs](http://libguestfs.org/).

### Don't know libguestfs?

If you're not familiar with libguestfs - it's a tool for offline image launching. Sounds weird? Maybe, but just for the first time.

It uses [qemu](http://qemu.org/) to start a custom, minimalistic OS (supermin appliance). This makes it very fast to boot, on my machine it's less than 5 seconds. You can mount disk images in various formats: vmdk, raw, qcow, even ISOs... Mounted disks are available to you - you can decide whether mount them in read-only fashion or make them fully writable.

[Libguestfs exposes a lot of API calls](http://libguestfs.org/guestfs.3.html#api_calls) that make it possible to check or modify your appliance. In BoxGrinder we use only a fraction of them, but even this small set makes us happy libguestfs users!

Libguestfs comes with a handy tool called guestfish which is a command line interface to libguestfs. This makes is super easy to debug your appliances and we use it a lot when developing BoxGrinder.

    $ guestfish -a centos-basic-sda.raw 
    
    Welcome to guestfish, the libguestfs filesystem interactive shell for
    editing virtual machine filesystems.
    
    Type: 'help' for help on commands
          'man' to read the manual
          'quit' to quit the shell
    
    ><fs> launch 
    ><fs> mount /dev/vda
    /dev/vda   /dev/vda1  /dev/vda2  
    ><fs> mount /dev/vda1 /
    ><fs> mount /dev/vda2 /b
    /bin   /boot  
    ><fs> mount /dev/vda2 /boot/
    ><fs> ls /
    bin
    boot
    dev
    etc
    home
    lib
    lib64
    lost+found
    media
    mnt
    opt
    proc
    root
    sbin
    selinux
    srv
    sys
    tmp
    usr
    var
    ><fs> cat /etc/hosts
    127.0.0.1		localhost.localdomain localhost
    ::1		localhost6.localdomain6 localhost6
    
    ><fs> 

And, most importantantly for us, **libguestfs is rock solid**. Go, try it - it's already in Fedora and RHEL!

### Integration tests and libguestfs

But how we can use libguestfs in our integration tests? So far we only tested for deliverable existence, which can only prove that something was created. But there are still some open questions. Is the artifact really readable? Does it contain data we wanted? **Here libguestfs comes to the rescue**.

After building we launch libguestfs, add the disk images and make sure everything is in place. Take a look at this example test:

    it "should build modular appliance based on Fedora and convert it to VirtualBox" do
      @config.merge!(:platform => :virtualbox)
      @appliance = Appliance.new("#{File.dirname(__FILE__)}/../appliances/modular.appl", @config, :log => @log).create

      GuestFSHelper.new([@appliance.plugin_chain[1][:plugin].deliverables[:disk]], @appliance.appliance_config, @config, :log => @log ).customize do |guestfs, guestfs_helper|
        guestfs.exists('/fedora-boxgrinder-test').should == 1
        guestfs.exists('/common-test-base-boxgrinder-test').should == 1
        guestfs.exists('/hardware-cpus-boxgrinder-test').should == 1
        guestfs.exists('/repos-boxgrinder-noarch-ephemeral-boxgrinder-test').should == 1
      end
    end

The above code **is a real test**. It'll create the appliance, convert it to virtualbox format and then make sure that the files that should be created exist. Not bad for 10 lines of code, huh?

## Future directions

Testing offline appliances makes a lot of sense - we want to make sure the image is valid. But does the upload process work as expected? Does the image boot correctly on the destination platform, especially on EC2? This is the next step we want to investigate.

We'll introduce a new step in addition to the 5 described above: uploading, launching the appliance and testing on a real instance. It could look similar to this (not working code):

    it "should build Fedora JEOS" do
      @config.merge!(:platform => :ec2, :delivery => :ebs)
      @appliance = Appliance.new("#{File.dirname(__FILE__)}/../appliances/mysql-fedora.appl", @config, :log => @log).create

      @ec2 = AWS::EC2::Base.new(:access_key_id => ACCESS_KEY_ID, :secret_access_key => SECRET_ACCESS_KEY)
      instance = @ec2.run_instances(:image_id =>  @appliance.plugin_chain.last[:plugin].deliverables[:ami]).instancesSet.item.first

      # Not implemented: wait for correct state instance.instanceState pending => started

      Net::SSH.start(instance.dnsName, 'ec2-user', :key_data => 'ASDASDASD' ) do |ssh|
        ssh.exec!('/etc/init.d/mysqld status').should match /is running/
        ssh.exec!('ps ax | grep [m]ysql | wc -l').should_not == '0'
      end

      @ec2.terminate_instance(:instance_id => instance.instanceId)
    end

This almost-working ruby code shows how easily we can extend our integration tests to run the tests on the right platform.

The idea of the above code is to create an appliance, convert it to EC2 format, upload to EC2 and launch. After the instance becomes available we'll connect to it using SSH, and check if the mysql daemon is really running. The instance is terminated afterwards.

We'll work on making this as clean as possible, abstracting the interactions with EC2 even more.

If you have any comments or ideas. Feel free to leave a note.
