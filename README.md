Seafile Professional Edition For yunohost
=================

[![Integration level](https://dash.yunohost.org/integration/seafile.svg)](https://ci-apps.yunohost.org/ci/apps/seafile%20%28Community%29/lastBuild/consoleFull)  
[![Install seafile with YunoHost](https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=seafile)

> *This package allow you to install seafile quickly and simply on a YunoHost server.  
If you don't have YunoHost, please see [here](https://yunohost.org/#/install) to know how to install and enjoy it.*

Overview
--------

Seafile is an open Source Cloud Storage application.

It's a Enterprise file sync and share platform with high reliability and performance. It's a file hosting platform with high reliability and performance. Put files on your own server. Sync and share files across different devices, or access all the files as a virtual disk.

**Shipped version:** Professional Edition 6.3.7

Screenshots
-----------

| Cross Platform File Syncing | Mobile File Access | Seafile Drive client : a new nice way to work with your files | File Sharing and Permission Control |
| :------------: | :------------: | :------------: | :------------: |
| ![](https://www.seafile.com/media/img/features/sync-client.jpg) | ![](https://www.seafile.com/media/img/features/mobile-ios-client.jpg) | ![](https://www.seafile.com/media/img/features/drive-client.png) | ![](https://www.seafile.com/media/img/features/sharing-dialog.png) |
| Seafile organize files into libraries. Each library can be synced into any desktop computer, including Windows, Mac and Linux. User can also selectively sync any folder. Unsynced files can be accessed via a feature called “cloud file browser”. Seafile has a fantastic performance in file syncing. Tens of thousands of small files can be synced in a minute. | Access files via Seafile mobile clients. Both Android and iOS are supported. Cached files can be used offline without the network environment. Users can also backup photos and contacts via the mobile clients. | Seafile Drive client let users to extend the local disk space with the massive storage capacity on the Seafile server by mapping storage space on Seafile server as a virtual drive. User can access all files in Seafile immediately, without syncing them. Files can be used offline too. | Libraries and folders can be shared to users or groups, with read-only or read-write permissions. Finer-grained permissions can be set to sub-folders after a folder is shared. Files can be shared to external users via sharing links. Sharing links can be protected by passwords and support setting an expiration date. |

| File Versioning and Snapshot | File locking | Online editing and co-authoring | Audit Log |
| :------------: | :------------: | :------------: | :------------: |
| ![](https://www.seafile.com/media/img/features/file-history.png) | ![](https://www.seafile.com/media/img/features/file-locking.jpg) | ![](https://www.seafile.com/media/img/features/edit-online.png) | ![](https://www.seafile.com/media/img/features/access-logs.jpg) |
| Seafile keeps versions for files and snapshots for folders. Users can restore a file or folder to an old version easily. Snapshot for folders is a handy way to protect files against ransomware. Using de-duplication technology, file versions are kept in an efficient way with reduced storage occupation. | Seafile supports file locking to prevent concurrent editing of files and generating of conflicts files. Users can lock files in web UI or desktop clients. Office files are automatically locked when they’re opened. | Seafile supports online editing and co-authoring for office files (including docx/pptx/xlsx) with integrating with Microsoft Office Online Server or Collabora Online server. Seafile also has a built-in preview for videos, audios, PDFs, images and text files. | Seafile has following logs to help you monitoring your system : Login log: Users'login log- Traffic log: Recording how much traffic is generated via sharing link for each user - Access log: file access log via syncing clients, mobiles clients and Web interface - Edit log: file editing/modification log - Permission log: logs for file access permission changes |

Demo
----

* [Official demo](https://demo.seafile.com/)

Documentation
-------------

 * Official documentation: https://manual.seafile.com/
 * YunoHost documentation: There no other documentations, feel free to contribute.

YunoHost specific features
--------------------------

### Multi-users support

This app support LDAP and the SSO authentification.

The restriction is that the user ID in this app is an email adress. So it's potentially possible to have multiple user account with the same username. By example you can have `john@yunohost.org` and `john@seafile.org`. You can see the issue [#5](https://github.com/YunoHost-Apps/seafile_ynh/issues/5) wich describe this problem. You can check that you are not in this case if by going in seafile admin page in the user tab can see all account.

The best configuration is to give to each user an email which contains the domain used by seafile.

### Supported architectures

Since seafile 6.3 the i386 architecture is no more supported.

Seafile no longer distribute binary for generic armhf architectures but rpi binary could work.

* x86-64b - [![Build Status](https://ci-apps.yunohost.org/ci/logs/seafile%20(Community).svg)](https://ci-apps.yunohost.org/ci/apps/seafile/)
* ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/seafile%20(Community).svg)](https://ci-apps-arm.yunohost.org/ci/apps/seafile/)
* Jessie x86-64b - [![Build Status](https://ci-stretch.nohost.me/jenkins/job/seafile%20(Community).svg)](https://ci-stretch.nohost.me/jenkins/job/seafile/)

<!--Limitations
------------

* Any known limitations.-->

Additional informations
-----------------------

### Change URL

Since now it's possible to change domain or the url of seafile but use it with precaution because it has not been tested enough for a big production installation. For the authentication and user every email for authentication will have the new domain name. For example `toto@old_domain.tld` will be `toto@new_domain.tld`.

To do this run : `yunohost app change-url seafile -d new_domain.tld -p PATH new_path

### Use a special user and put seafile binary in /opt dir :

In the new package version the install is by default in /opt dir, so it section is only usefull for user how as already installed seafile.  

To do this open a console and do this command :

```
# stop seafile server
sudo service seafile-server stop

# Move all data to opt and change user
sudo mv /var/www/seafile /opt/yunohost/seafile
sudo addgroup seafile --system --quiet
sudo adduser seafile --disabled-login --ingroup seafile --system --quiet --shell /bin/bash --home /opt/yunohost/seafile

# Adapt configuration
sudo sed -i "s@user=www-data@user=seafile@g" /etc/init.d/seafile-server 
sudo sed -i "s@seafile_dir=/var/www/seafile@seafile_dir=/opt/yunohost/seafile@g" /etc/init.d/seafile-server
sudo sed -i "s@alias /var/www/seafile/@alias /opt/yunohost/seafile/@g" /etc/nginx/conf.d/$(sudo yunohost app setting seafile domain).d/seafile.conf

# Set the good user for seafile
sudo chown seafile:seafile -R /opt/yunohost/seafile
sudo chown seafile:seafile -R /home/yunohost.app/seafile-data/

# Restart services
sudo rm -rf /tmp/seahub_cache
sudo systemctl daemon-reload
sudo service nginx reload
sudo service seafile-server start
```

Links
-----

 * Report a bug: https://github.com/YunoHost-Apps/seafile_ynh/issues
 * App website: https://www.seafile.com
 * YunoHost website: https://yunohost.org/

---

Install
-------

From command line:

`sudo yunohost app install -l seafile https://github.com/YunoHost-Apps/seafile_ynh`

Upgrade
-------

From command line:

`sudo yunohost app upgrade seafile -u https://github.com/YunoHost-Apps/seafile_ynh`

Developers infos
----------------

Please do your pull request to the [testing branch](https://github.com/YunoHost-Apps/seafile_ynh/tree/testing).

To try the testing branch, please proceed like that.
```
sudo yunohost app install https://github.com/YunoHost-Apps/seafile_ynh/tree/testing --debug
or
sudo yunohost app upgrade seafile -u https://github.com/YunoHost-Apps/seafile_ynh/tree/testing --debug
```

License
-------

Seafile server and its desktop clients are published under GPLv2.

Mobile clients are published under the GPLv3.

The Seafile server's web end, i.e. Seahub, is published under the Apache License.

This package is published under MIT License

TODO
----

- Find a way to fix the issue https://github.com/YunoHost-Apps/seafile_ynh/issues/5

