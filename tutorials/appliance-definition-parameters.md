---
title: "Appliance Definition parameters"
layout: one-column
---

# Parameters?

You can use several parameters in your appliance definitions (.appl files). They can be used, for example, in external repository definitions.

    name: postgis
    summary: PostGIS appliance
    appliances:
      - jeos
    repos:
      - name: "postgresql"
        baseurl: "http://yum.pgsqlrpms.org/8.3/#OS_NAME#/#OS_NAME#-#OS_VERSION#-#BASE_ARCH#/"
    packages:
      - postgresql
      - postgresql-server
      - postgis

> Warning: If you use parameters in your definition, make sure that **string containing this parameter is quoted**!

# Available parameters

## #ARCH# ##

Possible values (depends on your system):

* i386
* i686
* i586
* x86_64

## #BASE_ARCH# ##

Possible values:

* i386
* x86_64

## #OS_NAME# ##

Possible values:

* fedora
* rhel

## #OS_VERSION# ##

Release version or name, eg. 14 (fedora), 5 (RHEL),  rawhide (for Fedora developement).

