---
title: "BoxGrinder Build 0.9.4 released"
author: 'Marc Savy'
layout: blog
version: 0.9.4
timestamp: 2011-08-18t19:50:00.10+01:00
tags: [ boxgrinder_build ]
---

The release of BoxGrinder Build 0.9.4 is finally upon us.  This release primarily improves the performance and reliability of AWS related functionality within BoxGrinder Build, in addition to a range of miscellaneous bug-fixes and documentation improvements.
  
# What's new in 0.9.4?
Notable changes are summarised below, although the majority of improvements for this release are not directly visible to the end user.

You can update immediately from the Fedora `updates-testing` repository via:
    yum update -y 'rubygem-boxgrinder*' --enablerepo='updates-testing'

## S3 and EBS plugin enhancements and bug-fixes
Previously BoxGrinder used a couple of different community AWS libraries to enable interactions with Amazon's API.  However, we have now moved over to the recently released [official Ruby AWS library](http://aws.amazon.com/sdkforruby/); `aws-sdk`, which provides a much more comprehensive feature-set and clear object-oriented model than was available previously.  Furthermore, it is regularly maintained, so newer functionality should be exposed for use far more swiftly than was possible previously.    

In the course of rewriting the plugins to best utilise the new library, a variety of bugs were eliminated <sup>[1]</sup>, which should hopefully result in a far more consistent experience with the plugins <sup>[2]</sup>.

## Building on EC2 Micro instances
A reduction has been made to the amount of memory allocated to libguestfs in order to avoid running out of memory on EC2 Micro instances [[BGBUILD-246][]].  A welcome side-effect of the change is a decrease in build times on larger instances. 

## EBS AMI overwriting behaviour
The manner in which overwrite functionality works for EBS based AMIs has been changed slightly.  As outlined in [this developer mailing list post at length](http://markmail.org/message/xwyeqvblnj5oxqsq), it should provide a far more useful and stable way of overwriting an existing AMI.

    boxgrinder-build my.appl -p ec2 -d ami --delivery-config overwrite:true

Overwrite existing EBS AMI of the same name, version and release, specified in `my.appl`.  If any existing instances are running, the program will terminate with a warning before any irreversible actions occur. The base snapshot will be deleted.

    boxgrinder-build my.appl -p ec2 -d ami --delivery-config overwrite:true,terminate_instances:true
    
As above, but any running instances will automatically be terminated on your behalf.  Beware that this will delete any attached EBS volumes.  If you wish to preserve any particular EBS volume, simply detach it.

    boxgrinder-build my.appl -p ec2 -d ami --delivery-config overwrite:true,preserve_snapshots:true
    
As first example, but the base snapshot will not be deleted.  It will be orphaned, so if you wish to remove it later you will need to do so manually.


## Other points of interest
  - It is now possible for applications that modify the RPM database in the `post` section of your appliance to run without issue (such as YUM).
  - In addition to any functional changes, we've made some improvements to the documentation ([plugin](http://boxgrinder.org/tutorials/boxgrinder-build-plugins/), [appliance definition](http://boxgrinder.org/tutorials/appliance-definition/)) 
  - Any plugin developers should note that BoxGrinder has updated to [RSpec 2](http://relishapp.com/rspec) for testing [[BGBUILD-273][]].
  - Many improvements under the covers to the AWS-related plugins, if you are a plugin developer many new and existing functions are available in [AWSHelper][], [EC2Helper][] and [S3Helper][].

## Comprehensive Change-log

### Bug
  - [[BGBUILD-171][]] Log entries order is wrong
  - [[BGBUILD-238][]] stop annoying AWS gem messages
  - [[BGBUILD-249][]] Warning from S3 AMI plugin that BG is attempting to create a bucket that already exists
  - [[BGBUILD-263][]] NoMethodError: undefined method `item' for nil:NilClass while creating EBS appliance
  - [[BGBUILD-265][]] Resolve concurrency issues in S3 plugin for overwriting
  - [[BGBUILD-269][]] RPM database is recreated after post section execution preventing installing RPM in post section
  - [[BGBUILD-275][]] default_repos setting is not included in schema and is not documented
  - [[BGBUILD-290][]] Small documentation issues on boxgrinder.org

### Enhancement
  - [[BGBUILD-246][]] Detect when insufficient system memory is available for standard libguestfs, and reduce allocation.

### Task
  - [[BGBUILD-271][]] Make docs clearer about creating appliances for multiple EC2 regions
  - [[BGBUILD-272][]] Move from aws and amazon-ec2 to official aws-sdk gem
  - [[BGBUILD-273][]] Move to RSpec2
  - [[BGBUILD-278][]] Package aws-sdk gem into Fedora
  
  [BGBUILD-171]: http://issues.jboss.org/browse/BGBUILD-171
  [BGBUILD-238]: http://issues.jboss.org/browse/BGBUILD-238
  [BGBUILD-249]: http://issues.jboss.org/browse/BGBUILD-249
  [BGBUILD-263]: http://issues.jboss.org/browse/BGBUILD-263
  [BGBUILD-265]: http://issues.jboss.org/browse/BGBUILD-265
  [BGBUILD-269]: http://issues.jboss.org/browse/BGBUILD-269
  [BGBUILD-275]: http://issues.jboss.org/browse/BGBUILD-275
  [BGBUILD-290]: http://issues.jboss.org/browse/BGBUILD-290
  [BGBUILD-246]: http://issues.jboss.org/browse/BGBUILD-246
  [BGBUILD-271]: http://issues.jboss.org/browse/BGBUILD-271
  [BGBUILD-272]: http://issues.jboss.org/browse/BGBUILD-272
  [BGBUILD-273]: http://issues.jboss.org/browse/BGBUILD-273
  [BGBUILD-278]: http://issues.jboss.org/browse/BGBUILD-278
  
  [AWSHelper]: https://github.com/boxgrinder/boxgrinder-build/blob/0.9.4/lib/boxgrinder-build/helpers/aws-helper.rb
  [S3Helper]: https://github.com/boxgrinder/boxgrinder-build/blob/0.9.4/lib/boxgrinder-build/helpers/s3-helper.rb
  [EC2Helper]: https://github.com/boxgrinder/boxgrinder-build/blob/0.9.4/lib/boxgrinder-build/helpers/ec2-helper.rb


[1] AWS-related bugs resolved: [[BGBUILD-238][]], [[BGBUILD-249][]], [[BGBUILD-263][]], [[BGBUILD-265][]], [[BGBUILD-271][]], [[BGBUILD-272][]].

[2] There appears to be a regression in aws-sdk >1.0.2 that causes S3 overwrite to fail. Soon-to-arrive 0.9.5 will remedy this with a work-around. 
