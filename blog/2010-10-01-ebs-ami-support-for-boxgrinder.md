---
title: "EBS AMI support for BoxGrinder "
author: 'Marek Goldmann'
layout: blog
tags: [ ami, aws, boxgrinder_build, ebs ]
---

There
is one issue in BoxGrinder JIRA we have been asked since long time.
This is [BGBUILD-3](https://jira.jboss.org/browse/BGBUILD-3):
support for EBS-type AMI's. Yesterday I
[commited](http://github.com/stormgrind/boxgrinder-build-plugins/commit/dde86215635e63ba25a6cd2c241d631b66222b25)
initial support for this. What does it mean for you? Simple –
**you can now build appliances using BoxGrinder and then deliver them as EBS AMI's to Amazon Web Services.**
# It's here!

This was implemented as a
[new delivery plugin](http://community.jboss.org/docs/DOC-15921).
Be aware that currently only Fedora 13 is supported – we'll expand
support for other platform in the near future.

The plugin is not
yet released, it'll be released along with BoxGrinder Build 0.6.0
in the next weeks. If you want try it now – please
[download nightly artifacts from our CI](http://ci.boxgrinder.org/project.html?projectId=project2&tab=projectOverview&guest=1).
**Make sure you install also new version of boxgrinder-core and boxgrinder-build**
(also from CI) because the EBS plugin forced to make some changes
in the core. To do this please download all required gems, put them
in a directory and install them using this command:

    gem install *.gem

# How to use it?

It's just another delivery plugin. The only thing which is
different is that
**you must execute the build on an EC2 instance**. This is really
important. The reason is because we need to mount an EBS volume to
the instance and we can do this only on EC2. But don't be afraid –
we have
[meta appliance](http://www.jboss.org/boxgrinder/downloads/build/meta-appliance.html)
you can run on EC2 and use it to build your appliances.

    boxgrinder-build you_definition.appl -p ec2 -d ebs    

Of course make sure you created valid configuration
file for this plugin as
[described here](http://community.jboss.org/docs/DOC-15921) before
you start.
# I need help!

If you find bugs in that plugin, please
[report them in our issue tracker](https://jira.jboss.org/secure/CreateIssue.jspa?pid=12310920&issuetype=1).
You can always ask us for help on our
[forums](http://community.jboss.org/en/boxgrinder?view=discussions)
or on
our**new IRC channel: [\#boxgrinder](irc://irc.freenode.net/boxgrinder)****@ freenode.net**.
