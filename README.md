# Library Webiste

Testing [Drupal](https://www.drupal.org/home) as CMS for the new library website. This is because Sitefinity seems to be very restricted, and it's only for webpages, or listing publications at best.

## Prerequisite

Things that need to be installed before using Docker on your desktop

1. WSL2 (Windows only)
2. Docker (Desktop)

### Windows Subsystem for Linux

Install [WSL2][wsl_install] on the enable the _Hyper V_ virtualization.

### Docker 

Installed [Docker Desktop][desktop] to test combination Drupal and MySQL locally.

## Drupal

Using the example of `docker compose` for installing Drupal with MySQL.

During the configuration, the database hostname is _db_ not _localhost_ in the _advanced_ options.

The default localtion of the Drupal _root_ directory, as defined in the `compose` file, is 

```
root@a405cbfee69b:/var/www/html/sites/default# pwd; ll
/var/www/html/sites/default
total 76K
-rw-r--r-- 1 www-data www-data 6.7K May  7 00:36 default.services.yml
-rw-r--r-- 1 www-data www-data  32K May  7 00:36 default.settings.php
drwxrwxr-x 7 www-data www-data 4.0K May 11 18:46 files/
-r--r--r-- 1 www-data www-data  32K May 11 18:35 settings.php
root@a405cbfee69b:/var/www/html/sites/default#
```

Installed the [W3CSS][w3csspage] [theme][w3theme], with predefined color "W3 CSS Theme 00014."


[wsl_install]: https://docs.microsoft.com/en-us/windows/wsl/install-win10 "WSL2 Install"
[desktop]: https://www.docker.com/products/docker-desktop "Docker Desktop page"
[w3csspage]: https://drupal8-w3css-theme.flashwebcenter.com/ "W3CSS theme for Drupal 8 and 9"
[w3theme]: https://www.drupal.org/project/d8w3css "Drupal W3CSS theme page"