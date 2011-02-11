---
title: "RHQ CLI &#x2013; configuring and importing resources"
author: 'Marek Goldmann'
layout: blog
tags: [ cirras, rhq ]
---

RHQ is the
underlying platform for all management projects from JBoss:
commercial supported
[JBoss Operation Network](http://www.jboss.com/products/jbosson/)
and [JOPR](http://jboss.org/jopr) – a community based monitoring
and managing suite.

Some time ago RHQ developers
[announced](http://www.rhq-project.org/display/RHQ/2009/12/11/Developer+Release+1.4.0-B01)
new RHQ build including all JOPR plugins. After that we decided to
move from [JOPR](http://jboss.org/jopr) to
[RHQ](http://www.rhq-project.org/display/RHQ/Home) and use
[latest](http://www.rhq-project.org/display/RHQ/Download) developer
build.

# RHQ/JOPR in the Cloud

CirrAS goal is to deploy a cluster of JBoss AS without user
interaction at all. Now, we're **expanding** the goal and adding a
monitoring and management (still no user actions needed!).

On each
node we're installing an RHQ Agent. To be honest it is installed
automatically after the node (front-end, back-end) is started.
Every node grabs plugin binary from RHQ Server. The binary is
installed then and finally a RHQ Agent is launched.

An agent is
responsible for gathering information about running services and
reporting that to RHQ server which is located on management
appliance. A discovered node is added to Discovery Queue in RHQ
Server. This was a scratch on glass – earlier an administrator was
forced to log in into RHQ console and import selected resources.
**This is now over!**

Second thing we wanted to avoid is to
configure any plugin to have a working monitoring suite.
Unfortunately
[Apache HTTP Server plugin](http://www.rhq-project.org/display/JOPR2/Apache+HTTP+Server)
requires an URL to put into configuration. This URL is used for
checking availability. We worked it out too using RHQ CLI.
# RHQ CLI

RHQ has a powerful
[Command Line Interface](http://www.rhq-project.org/display/JOPR2/Running+the+RHQ+CLI)
included. Before you're able to use it, you need to
[install it](http://www.rhq-project.org/display/JOPR2/RHQ+CLI+Installation)
properly (not a big deal). If you think RHQ CLI language looks
familiar, yes, you're right – it's JavaScript, but extended to use
also Java objects.

There are two ways you can use this CLI:
interactive and non-interactive. In interactive mode you have a
Bash-like command line where you execute commands.
[Greg Hinkle described it](http://www.jroller.com/ghinkle/entry/autocomplete_and_the_rhq_cli)
very well. In non interactive mode all commands located in a file
are executed. Your choice.

Before we start I need to mention that
JavaDocs for RHQ
[Remote API](http://www.redhat.com/docs/en-US/JBoss_ON/2.3/api/remote-api/)
and
[domain](http://www.redhat.com/docs/en-US/JBoss_ON/2.3/api/domain/)
are very helpful!

Let's begin! First of all we want to grab all
discovered but not imported Apache HTTP servers.

    var criteria = new ResourceCriteria();
    criteria.addFilterResourceTypeName("Apache HTTP Server");
    criteria.addFilterInventoryStatus(InventoryStatus.NEW);
    var httpd_servers = ResourceManager.findResourcesByCriteria(criteria);


A list of resources is returned, we can print all elements:

    if (httpd_servers != null && httpd_servers.size() > 0) {
        for (var i = 0; i < httpd_servers.size(); i++) {
            var resource = httpd_servers.get(i);
            println(" - " + resource.name);
        }
    } else {
        println("No servers found.")
    }

## Making changes in plugin configuration

We want to get the configuration for agent connection which we want
to modify. We need to grab a proxy object for selected resource.
[Proxy objects](http://www.rhq-project.org/display/JOPR2/Running+the+RHQ+CLI#RunningtheRHQCLI-Proxy)
are simplifying interaction with RHQ resources.

    var httpd = ProxyFactory.getResource(httpd_servers.get(0).id);

From that object we need to grab plugin configuration which we need
mot alter:

    var httpd_configuration = httpd.getPluginConfiguration();

Last step is to simply modify property we want:

    httpd_configuration.getSimple("url").setStringValue("http://10.1.0.3");
    httpd.updatePluginConfiguration(httpd_configuration);

Plugin configuration is now modified. Simple, huh?

## Importing resources

Next we want to import resources we discovered earlier. It is as
simple as executing `importResources` function:

    DiscoveryBoss.importResources(httpdResourceIds);

Please be aware that this command takes one argument – an array of
resource ids. You'll get also an error when you try to import a
resource with a parent resource which is not imported. You need to
import resources in the proper order, remember! You can use for
that function like this:

    httpdResourceIds = [];

    for (i = 0; i < httpd_servers.size(); i++) {
        addDependencyIds(httpd_servers.get(i), httpdResourceIds);
    }

    function addDependencyIds(resource, array) {
        var parent = ResourceManager.getResource(resource.id).getParentResource();

        if (parent != null) {
            addDependencyIds(parent, array);
        }

        array.push(resource.id);
    }

# Conclusion

RHQ CLI is really great. Above example is only a tip of the iceberg
what you can do with it. In CirrAS we're using a
[bigger script](http://github.com/stormgrind/cirras-rpm/blob/master/src/import-servers.js)
which solved our problem with auto importing and reconfiguring
servers. You can take a look, maybe it'll help you with your
problem too!