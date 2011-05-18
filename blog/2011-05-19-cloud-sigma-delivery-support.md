---
title: "CloudSigma delivery tutorial"
author: 'Marc Savy'
layout: blog
timestamp: 2011-05-19t20:15:00.10+01:00
tags: [ boxgrinder_build, howto, cloudsigma, elastichosts ]
---

BoxGrinder Build encapsulates powerful functionality, such as the ability to define, build and deliver an appliance, into a simple and concise pipeline. Ultimately, only a single command needs executing in order to build, convert and deliver a custom-defined appliance into your chosen environment.

For some use-cases appliances might only be run within internal or private infrastructure, hence BoxGrinder provides [local file-system delivery and SFTP support](/tutorials/boxgrinder-build-plugins/).  However, BoxGrinder also offers similarly succinct platform conversion and delivery methods for public infrastructure, and as of release 0.9.2 support has been added for [CloudSigma](http://www.cloudsigma.com/), a provider of cloud services throughout Europe.

In this blog-post we demonstrate a basic, but complete, work-flow to specify, build and deliver an appliance to CloudSigma.

## Define your Appliance
The starting point of any appliance is an Appliance Definition File; an extremely simple YAML text definition to describe the virtual machine you would like to produce.  There is support for a wide range of [features to customise](/tutorials/appliance-definition/) the image for your specific requirements, however for this post we will only produce a simple definition to illustrate the pertinent functionality.

    name: sigma-jeos
    summary: Just Enough Operating System
    os:
      name: fedora
      version: 15
      password: boxgrinder-rules
    post:
      base:
        - /bin/echo "I am a CloudSigma appliance!" >> /what-am-i
	
Save the file as ___sigma-jeos.appl___.

There are very few mandatory fields, in almost all instances a sensible value will be provided as a default.  For instance, we leave BoxGrinder to provide a root partition, and a base set of packages to provide a functional Fedora OS.  The only CloudSigma specific part of this appliance is in the _post_ section, where we can specify commands to be executed _after_ the standard build process has completed.  In this example we echo a trivial message into a file, but you could perform any legal shell commands and BoxGrinder will run them on your behalf.  

If you need to perform complex software installation and configration, it is advisable to [encapsulate the scripts in RPMs](/tutorials/how-to-use-local-repository/), carefully describing the dependencies and requirements.  Your scripts will be installed in the same phase as other RPMs, ensuring that any dependencies are properly resolved before execution occurs.

## What's the Secret Number?
The CloudSigma plugin requires [specific configuration information](/tutorials/boxgrinder-build-plugins/#ElasticHosts_Delivery_Plugin) in order to deliver appliances.  BoxGrinder stores this information in a consolidated plugins file, located at `$HOME/.boxgrinder/plugins`.  As CloudSigma uses a variant of the ElasticHosts API, configuration is provided under this subsection.

    plugins:
      elastichosts:
        endpoint: api.cloudsigma.com                      # required
        username: your@registered-email-address.com       # required
        password: whisper                                 # required
        chunk: 128                                        # default: 64 (in MB)
        start_part: 0                                     # default: 0
        wait: 5                                           # default: 5 (in s)
        retry: 5                                          # default: 3
        ssl: true                                         # default: false
        #drive_uuid:                                      # optional
        #drive_name:                                      # optional
	
Only the __endpoint__, __username__, and __password__ are required attributes, BoxGrinder will either use a sensible default, or derive a value where appropriate.

## BoxGrinder Build, Make it So!
There is now sufficient information available to build, convert and deliver an appliance to CloudSigma. We now simply execute BoxGrinder Build with the CloudSigma delivery flag on the command line as _root_, and the hard work will be performed for us.

    boxgrinder-build sigma-jeos.appl -d elastichosts

All packages required to build a basic Fedora 15 image will be downloaded and installed into a RAW imagefile. Once completed, the image is broken into chunks and uploaded to the CloudSigma account specified above.

BoxGrinder will inform you of the __Server UUID__ and __Drive UUID__ for your appliance.
    
    I, [2011-05-18T18:55:27.201579 #14223]  INFO -- : Appliance f15-jeos uploaded to drive with UUID b161fd8b-d56s-4eea-9055-669daaec8aa4.
    I, [2011-05-18T18:55:27.202616 #14223]  INFO -- : Appliance uploaded.
    I, [2011-05-18T18:55:27.203164 #14223]  INFO -- : Creating new server...
    I, [2011-05-18T18:55:28.155540 #14223]  INFO -- : Server was registered with 'f15-jeos-1.0' name as '02c80862-0282-4014-af28-d751fee1dead' UUID. Use web UI or API tools to start your server.

### Lift-Off  
You can launch either via CloudSigma's API tools using the UUIDs, or the Web UI, where you should be able to see your newly uploaded appliance under __My Servers__ and __My Drives__.  After launching an instance, you can connect via SSH, with the __root__ user account and password set in the appliance definition; __boxgrinder-rocks__. 

![image](/images/screenshots/boxgrinder-sigma-ui.png "CloudSigma Web UI")

## Effortless 
With these simple steps, BoxGrinder Build has created a virtual appliance from scratch, and delivered it to the CloudSigma cloud.  It is easy to envisage how BoxGrinder Build can be harnessed to bake a range of compact, [specialised appliances](/tutorials/how-to-customize-appliance/) to fulfil the roles you require in your deployed applications.

The easiest way to try out BoxGrinder Build is with our [Meta Appliances](/download/boxgrinder-build-meta-appliance/), that provide a pre-configured environment ready for grinding out appliances.
