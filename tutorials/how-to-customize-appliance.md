---
title: "How to customize appliance"
layout: one-column
---

> Note: This is a DRAFT.

If you need a specialized and not a minimal appliance (common case). You can add packages and/or appliances you want. Let's prepare a bare minimum [appliance definition file][appl]. The only required section is name. Of course to have a working appliance you have to specify some packages too.

# Adding packages

Edit your appliance definition file (`your-appliance-appliance.appl`) and add packages section like this:

    name: my-appliance-name
    summary: One sentence description of your appliance
    packages:
      - httpd
      - gcc
      - mc

You can add as many packages as you want. There is implemented dependency tracking, so don't worry about dependencies, just put there packages you want.

> Note: formatting is like: two spaces, minus sign, space, package name!

# Adding appliances

If you could add only packages to appliance this would be boring (and too simple for us). You can add appliances too!

    name: my-appliance-name
    summary: One sentence description of your appliance
    appliances:
      - jeos
      - another-appliance

> Note: format is same as with packages.

How is it working? We get all informations from both (or more) specified appliances and merge this into one.

# How about mixing everything?

Yes, it's true - you can mix packages with appliances:

    name: my-appliance-name
    summary: One sentence description of your appliance
    packages:
      - httpd
      - gcc
      - mc
    appliances:
      - jeos
      - another-appliance

# Adding external repositories

Say you want to add packages to your appliance from other (not default) repositories. You can add these repositories to your .appl  file, and then simply add required package name in packages section.

Sample external repository:

    name: my-appliance-name
    summary: One sentence description of your appliance

    repos:
      - name: external-repo
        baseurl: http://somehost/repo/
    packages:
      - httpd
      - gcc
      - mc
      - package-from-external-repo
    appliances:
      - jeos

# Parameters in appliance definitions

There are several parameters you can use in .appl files. Take a look at [appliance definition parameters][params].

# Need more detailed information?

Please refer to [appliance defintion structure][appl] description.

[appl]: /tutorials/appliance-definition
[params]: /tutorials/appliance-definition-parameters
