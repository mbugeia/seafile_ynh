Seafile for YunoHost
=================

[![Integration level](https://dash.yunohost.org/integration/seafile.svg)](https://dash.yunohost.org/appci/app/seafile) ![](https://ci-apps.yunohost.org/ci/badges/seafile.status.svg) ![](https://ci-apps.yunohost.org/ci/badges/seafile.maintain.svg)  
[![Install seafile with YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=seafile)

> *This package allow you to install seafile quickly and simply on a YunoHost server.  
If you don't have YunoHost, please see [here](https://yunohost.org/#/install) to know how to install and enjoy it.*

Overview
--------

Seafile is an open Source Cloud Storage application.

It's a Enterprise file sync and share platform with high reliability and performance. It's a file hosting platform with high reliability and performance. Put files on your own server. Sync and share files across different devices, or access all the files as a virtual disk.

**Shipped version:** 8.0.5

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

If you have Seafile installed before 7.x and you have more than one domain for users in Yunohost or Seafile app is installed on a different domain, you need to migrate your accounts.
You can use the provided action at https://domain.tld/yunohost/admin/#/apps/seafile/actions. You can also use this following command to migrate all of your accounts:
```
yunohost app action run seafile migrate_user_email_to_mail_email
```
See [issue#44](https://github.com/YunoHost-Apps/seafile_ynh/issues/44)
for more information.

### Supported architectures

Since seafile 6.3 the i386 architecture is no more supported.

Seafile don't distribute binary for generic armhf architectures but rpi binary generally work on all arm board.

* x86-64 - [![Build Status](https://ci-apps.yunohost.org/ci/logs/seafile%20%28Apps%29.svg)](https://ci-apps.yunohost.org/ci/apps/seafile/)
* ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/seafile%20%28Apps%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/seafile/)

<!--Limitations
------------

* Any known limitations.-->

Additional informations
-----------------------

### Links

 * Report a bug: https://github.com/YunoHost-Apps/seafile_ynh/issues
 * App website: https://www.seafile.com
 * YunoHost website: https://yunohost.org/

---

### Install

From command line:

`yunohost app install seafile`

### Upgrade

By default a backup is made before the upgrade. To avoid this you have theses following possibilites:
- Pass the `NO_BACKUP_UPGRADE` env variable with `1` at each upgrade. By example `NO_BACKUP_UPGRADE=1 yunohost app upgrade synapse`.
- Set the settings `disable_backup_before_upgrade` to `1`. You can set this with this command:

`yunohost app setting synapse disable_backup_before_upgrade -v 1`

After this settings will be applied for **all** next upgrade.

From command line:

`yunohost app upgrade seafile`

### Backup

This app use now the core-only feature of the backup. To keep the integrity of the data and to have a better guarantee of the restoration is recommended to proceed like this:

- Stop seafile service with theses following command:

`systemctl stop seafile.service seahub.service`

- Launch the backup of seafile with this following command:

`yunohost backup create --app seafile`

- Do a backup of your data with your specific strategy (could be with rsync, borg backup or just cp). The data is stored in `/home/yunohost.app/seafile-data`.
- Restart the seafile service with theses command:

`systemctl start seafile.service seahub.service`

### Remove

Due of the backup core only feature the data directory in `/home/yunohost.app/seafile-data` **is not removed**. It need to be removed manually to purge app user data.

### Change URL

Since now it's possible to change domain or the url of seafile.

To do this run : `yunohost app change-url seafile -d new_domain.tld -p PATH new_path`

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
