---
title: "How to use local RPM repository"
layout: one-column
---

Not all software you need will be available in a repository you can freely access. Sometimes you need to build the software (or download binary files). In that case you are still able to include the software in your appliances. Here is how to do this.

# Creating local repository

We assume you are on Fedora or RHEL-based distribution.

## Package your software

Build or download the RPM (take a look at the [Fedora RPM Guide](http://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html/RPM_Guide/) - very nice and detailed info on how to create an RPM specification file). Once you get your software - put it into a directory in your system. We'll use /opt/repo in this example.

    mkdir -p /opt/repo/RPMS/i386 /opt/repo/RPMS/noarch /opt/repo/RPMS/x86_64

## Add RPMS to the local repository

To add RPMS to the local repository, simply copy the RPM to the proper repository directory.

## Create repository with `createrepo` command

### Install createrepo package

There is a createrepo utility which creates all of the required metadata to convert a normal directory into an RPM repository.

    yum install createrepo

Now simply run:

    createrepo /opt/repo/RPMS/i386
    createrepo /opt/repo/RPMS/x86_64
    createrepo /opt/repo/RPMS/noarch

This command will convert the directories into an RPM repository usable by YUM command.

> Note: If you update any RPMs in your local repo, or wish to introduce new RPMs, you must re-run createrepo command!

# Add repository to your appliance definition

Now it's time to create or update the repos section in your [appliance definition file][appl].

    repos:
      - name: "local-noarch"
        baseurl: "file:///opt/repo/RPMS/noarch"
        ephemeral: true
      - name: "local-#ARCH#"
        baseurl: "file:///opt/repo/RPMS/#ARCH#"
        ephemeral: true

Now you're ready to build your appliance!

> Note: By default every reposository in an .appl file will be added to the appliance. If you set `ephemeral: true` the repository you specify will be used only for installing your software, and will be not added to the YUM config of the resultant appliance.

[appl]: /documentation/articles/appliance-definition-file