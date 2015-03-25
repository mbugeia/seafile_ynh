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

This will install Seafile v4.1.1 with HTTPS Sync only. /!\Not available on ARM for now /!\

Infos
-----

Seafile server v4.0.6

Available for x64, i386 and arm (Raspberry) architecture but only tested for x64 (feedback are welcome)

TODO
-----

 - Webdav configuration
 - Auto login/logout
 - logrotate configuration