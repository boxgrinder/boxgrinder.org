---
title: "Appliance Definition parameters"
layout: one-column
---

> Note: This is a DRAFT.

# Parameters?

You can use several parameters in your appliance definitions (.appl files). They can be used, for example, in external repository definitions.

    name: postgis
    summary: PostGIS appliance
    appliances:
      - jeos
    repos:
      - name: "postgresql"
        baseurl: http://yum.pgsqlrpms.org/8.3/#OS_NAME#/#OS_NAME#-#OS_VERSION#-#BASE_ARCH#/
    packages:
      - postgresql
      - postgresql-server
      - postgis

# Available parameters

## #ARCH# ##

Possible values:

* i386
* x86_64

## #OS_NAME# ##

Possible values:

* fedora
* rhel

## #OS_VERSION# ##

Release version or name, eg. 14 (fedora), 5 (RHEL),  rawhide (for Fedora developement).

