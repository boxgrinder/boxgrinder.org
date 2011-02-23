---
title: "Reporting BoxGrinder Build bugs"
author: 'Marek Goldmann'
layout: blog
tags: [ boxgrinder_build, bug, issues ]
---

So,
you've installed BoxGrinder and you get an error while building
your appliance? You need help and we'll provide it! But there are
couple of things you should do before reporting a bug.

1.  First of all -
    **search [our issue tracker](https://jira.jboss.org/browse/BGBUILD) for similar bugs**.
    Maybe it's already reported? If yes, please add a new comment -
    we'll respond to it.
2.  **Search our [forums](http://community.jboss.org/en/boxgrinder?view=discussions)** - we have there a lot traffic and almost all known bugs were
    discussed there.
3.  If you couldn't find anything similar to your issue -
    **[start a new thread](http://community.jboss.org/community/post!input.jspa?containerType=14&container=2232)**
    and describe your issue or directly
    **[open a new bug report](https://jira.jboss.org/secure/CreateIssue.jspa?pid=12310920&issuetype=1)**
    in JIRA. Please attach additional information such like:

    -   Which BoxGrinder version are you using? What OS? Which
        libguestfs version you have installed? Use these commands:
        `rpm -qa | grep boxgrinder` and/or `gem list | grep boxgrinder`
        and `rpm -q libguestfs`.
    -   How did you installed BoxGrinder? (Meta appliance? Which
        version? Where do you run it? EC2? VMware? KVM?)
    -   Attach as much logs as you can for affected build. Logs are
        located in *log/boxgrinder.log* file. But, please strip the content
        and attach only logs for last run.
    -   Describe your issue best you can - this really helps!

If you follow above steps - we'll be able to react
**faster and solve your problem**!

We're also available on **IRC**: #boxgrinder @ irc.freenode.net where we can answer your questions
too!