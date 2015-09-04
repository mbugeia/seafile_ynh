Seafile for Yunohost
============

Seafile is an open Source Cloud Storage application.

Official website: <http://seafile.com/>

Requirements
------------

Functionnal instance of [Yunohost](https://yunohost.org/#/)

Installation
------------

From command line:

`sudo yunohost app install -l Seafile https://github.com/mbugeia/seafile_ynh`

Upgrade
-------

From command line:

`sudo yunohost app upgrade -l Seafile https://github.com/mbugeia/seafile_ynh seafile`

This will install Seafile v4.3.1 with HTTPS Sync only.

Infos
-----

Seafile server v4.3.1

Available for x64, i386, armhf and Raspberry architecture but only tested for x64 (feedback are welcome)

In armhf it don't run actually. Please see this issue : https://github.com/haiwen/seafile/issues/1358

TODO
-----

 - Auto login/logout
