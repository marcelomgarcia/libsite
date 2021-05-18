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

### Finder Module

Created a second Drupal container to install the "finder" module. The first attempt to install the module was via PHP [composer][php_composer]. The installation failed due to memory exaustion.

```
root@78e6a02a78fb:/var/www/html/modules# composer require cubear/finder
(...)
Fatal error: Allowed memory size of 1610612736 bytes exhausted (tried to allocate 134217736 bytes) in phar:///usr/local/bin/composer/src/Composer/DependencyResolver/RuleSet.php on line 83
```

Indeed the container had very low memory limit

```
root@78e6a02a78fb:/var/www/html/modules# php -r "echo ini_get('memory_limit').PHP_EOL;"
128M
root@78e6a02a78fb:/var/www/html/modules#
```

Disabling the [memory limit check][composer_memory], and trying the installation again

```
root@78e6a02a78fb:/var/www/html/modules# php -d memory_limit=-1 composer.phar require cubear/finder
No composer.json in current directory, do you want to use the one at /opt/drupal? [Y,n]?
Using version dev-master for cubear/finder
  (...)
```

This time failed because the modules `unzip` and `git` weren't installed on the container.

[wsl_install]: https://docs.microsoft.com/en-us/windows/wsl/install-win10 "WSL2 Install"
[desktop]: https://www.docker.com/products/docker-desktop "Docker Desktop page"
[w3csspage]: https://drupal8-w3css-theme.flashwebcenter.com/ "W3CSS theme for Drupal 8 and 9"
[w3theme]: https://www.drupal.org/project/d8w3css "Drupal W3CSS theme page"
[php_composer]: https://getcomposer.org/ "PHP composer"
[composer_memory]: https://getcomposer.org/doc/articles/troubleshooting.md#memory-limit-errors "Composer memory limit error"
