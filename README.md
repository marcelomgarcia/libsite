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

Using the example of `docker compose` for installing Drupal with MySQL. Please note that during the configuration of Drupal, the database hostname is _db_ not _localhost_ in the _advanced_ options. Also note that the original container is already configured with [composer][php_composer], this means, that it's already installed on the container, and ready to use.

Installed the [W3CSS][w3csspage] [theme][w3theme], with predefined color "W3 CSS Theme 00014."

### Finder Module

Created a second Drupal container to install the "finder" module. The first attempt to install the module was via `composer`. The installation failed due to memory exaustion.

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

This time failed because the modules `unzip` and `git` weren't installed on the container. The solution was to create a new container _finder_ to install Drupal and the modules. To create a custom image for Drupal, a new entry on the `docker-composer.yml` was created, and it's important to declare the _build_ section, where we specify the `Dockerfile` for the container. The `context` is a key word that specify the working directory, in this case, it's the directory with all the files.

```
(...)
  finder:
    build:
      context: .
      dockerfile: ./finder.Dockerfile
(...)
```

After creating the image, we installed the module _finder_ using the composer on the _site root_ `/opt/drupal/web`

```
root@99642be2ac8d:/opt/drupal/web# php -d memory_limit=-1 `which composer` require cubear/finder
(...)
Package operations: 5 installs, 0 updates, 0 removals
  - Installing phpmailer/phpmailer (v6.4.1): Downloading (100%)
  - Installing drupal/smtp (1.0.0): Downloading (100%)
  - Installing drupal/entity_reference_revisions (1.9.0): Downloading (100%)
  - Installing drupal/paragraphs (1.12.0): Downloading (100%)
  - Installing cubear/finder (dev-master e223034): Cloning e223034b27 from cache
(...)  
```


[wsl_install]: https://docs.microsoft.com/en-us/windows/wsl/install-win10 "WSL2 Install"
[desktop]: https://www.docker.com/products/docker-desktop "Docker Desktop page"
[w3csspage]: https://drupal8-w3css-theme.flashwebcenter.com/ "W3CSS theme for Drupal 8 and 9"
[w3theme]: https://www.drupal.org/project/d8w3css "Drupal W3CSS theme page"
[php_composer]: https://getcomposer.org/ "PHP composer"
[composer_memory]: https://getcomposer.org/doc/articles/troubleshooting.md#memory-limit-errors "Composer memory limit error"
