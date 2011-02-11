---
title: "Announcing StormGrind (and new releases!)"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder, cantiere, cirras ]
---

Welcome to our new blog!

# Introducing StormGrind Blog

This is a successor of [oddthesis.org](http://oddthesis.org/) blog.
Here you'll find articles and announcement of new releases for all
StormGrind projects. P.S. All cloud related articles located at
[oddthesis.org](http://oddthesis.org/) will be migrated shortly, so
don't be afraid :)

# Introducing StormGrind

[StormGrind](http://www.jboss.org/stormgrind) located on
[JBoss community](http://jboss.org/) pages is an umbrella for cloud
projects found in JBoss. If you have questions about the project
read first our [FAQ](http://community.jboss.org/docs/DOC-14371)
document located on our new
[Wiki](http://community.jboss.org/docs/DOC-14360). We'll
consequently update this document to answer all your big questions.
Currently under StormGrind we have 7 projects:

* [Cantiere](http://www.jboss.org/stormgrind/projects/cantiere.html) -- RPM building helper,
* [BoxGrinder](http://www.jboss.org/stormgrind/projects/boxgrinder.html) -- Set of appliance tools;
    * [BoxGrinder Build](http://www.jboss.org/stormgrind/projects/boxgrinder/build.html) -- tool for building appliances
    * [BoxGrinder REST](http://www.jboss.org/stormgrind/projects/boxgrinder/rest.html) -- REST interface to BoxGrinder Build
    * BoxGrinder Studio – web interface to BoxGrinder Build (no website yet – in planning),
* [CirrAS](http://www.jboss.org/stormgrind/projects/cirras.html) -- JBoss AS clustering in the Cloud.

A few of above projects are new, others are refactored, enhanced
and renamed projects from oddthesis.org incubator.
[More information](http://community.jboss.org/docs/DOC-14372) about
name changes you can find on
[our wiki](http://community.jboss.org/wiki/StormGrindDocumentation).
Source code was also migrated to new location. We're still on
[GitHub](https://github.com/) – check out
[stormgrind user](http://github.com/stormgrind)! More info on
source code on our
[project site](http://www.jboss.org/stormgrind/sourcecode.html). If
you're still confused with name transition feel free to ask us on
[IRC](irc://irc.freenode.net/stormgrind), see below for more
information.
## Community and contact with developers

We currently don't have new mailing list. We're in the process of
setting up forums for you. Forum availability will be announced in
a separate post. If you're using IRC, we're ready for a talk in
[\#stormgrind](irc://irc.freenode.net/stormgrind) room on
freenode.net. We have of course a shiny new
[Twitter account](http://twitter.com/stormgrind), follow us! Always
up-to-date information about community you can find on our
[community page](http://www.jboss.org/stormgrind/community.html).
Our new
[issue trackers](http://www.jboss.org/stormgrind/issues.html) are
ready for your input!
# New releases

We're also happy to announce first versions of
[CirrAS](#cirras-1.0.0.Beta1),
[BoxGrinder Build](#boxgrinder-build-1.0.0.Beta1) and
[Cantiere](#cantiere-1.0.0.Beta1).
## BoxGrinder Build 1.0.0.Beta1 released!

First Beta version of
[BoxGrinder Build](http://www.jboss.org/stormgrind/projects/boxgrinder/build.html)
is out now! BoxGrinder Build is a project formerly know as JBoss
Appliance Support – a set of Rake tasks to build appliances from
simple plain text appliance definitions. You can find more
information on
[BoxGrinder Build](http://www.jboss.org/stormgrind/projects/boxgrinder/build.html)
on
[project page](http://www.jboss.org/stormgrind/projects/boxgrinder/build.html)
and
[documentation wiki](http://community.jboss.org/wiki/StormGrindBoxGrinderDocumentation).
### 1.0.0.Beta1 highlights

With the move to BoxGrinder from JBoss Appliance Support,
**appliance definition files structure has changed**. Now you don't
need to specify OS name and version (and many more!) via command
line parameters, everything now is in one place – in appliance
definition file.
[Read more](http://community.jboss.org/docs/DOC-14359) about new
appliance definition file structure on our wiki. We
**removed wizard** feature in this version. Wizard was good when we
had many command line parameters, but now we're using simple plain
text appliance definition files and every information you're
earlier specifying in command line parameters you can now put
conveniently in this file.
### Download

Release notes for Beta1 can be found
[here](https://jira.jboss.org/jira/browse/BGBUILD/fixforversion/12314240)
and release is available for immediately download on the
[download page](http://www.jboss.org/stormgrind/downloads/boxgrinder.html).
## CirrAS 1.0.0.Beta1 released!

A first version of
[CirrAS](http://www.jboss.org/stormgrind/projects/cirras.html) –
1.0.0.Beta1 is also out! CirrAS is an effort make deploying of
[JBoss AS](http://www.jboss.org/jbossas/) cluster in the Cloud as
smooth as possible. More information is available on
[CirrAS project page](http://www.jboss.org/stormgrind/projects/cirras.html)
and in [the wiki](http://community.jboss.org/docs/DOC-14399).
### 1.0.0.Beta1 highlights

CirrAS is **[JBoss AS 6.0.0.M1](http://www.jboss.org/jbossas/)**
based! (JBoss Cloud was using JBoss AS 5). This helped to fix
[CIRRAS-6](https://jira.jboss.org/jira/browse/CIRRAS-6). CirrAS has
a **standalone JOPR** installation for monitoring and managing
services. The cool thing is that every discovered node is
registered automatically. JOPR itself is automatically deployed on
management appliance without the need to run configuration wizard,
etc. To access JOPR console just point your browser to management
appliance address and port 7080. Username and password are default
for JOPR installations: **rhqadmin**/**rhqadmin**.
### Download

Summary of work done is available
[here](https://jira.jboss.org/jira/browse/CIRRAS/fixforversion/12314208).
You can download CirrAS bits from
[CirrAS download page](http://www.jboss.org/stormgrind/downloads/cirras/1-0-0-Beta1.html).
## Cantiere 1.0.0.Beta1 released!

All RPM building stuff from previous JBoss Appliance Support is now
moved to Cantiere. It is a helper tool for building RPM files from
spec files. For more information about using Cantiere refer to
[our wiki](http://community.jboss.org/docs/DOC-14533).
### Download

You can download Cantiere from
[download page](http://www.jboss.org/stormgrind/downloads/cantiere.html).