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

`sudo yunohost app upgrade -u https://github.com/mbugeia/seafile_ynh seafile`

Infos
-----

Seafile server v4.4.3

Available for x64, i386, and Raspberry architecture but only tested for x64 (feedback are welcome)

Seafile no longer supports armhf architectures AFAIK.

/!\ To login use your yunohost email not your username.

TODO
-----

 - Auto login/logout
