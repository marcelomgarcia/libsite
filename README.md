# Library Webiste

Testing [Drupal](https://www.drupal.org/home) as CMS for the new library website. This is because Sitefinity seems to be very restricted, and it's only for webpages, or listing publications at best.

## Prerequisite

Things that need to be installed before using Docker on your desktop

1. WSL2 (Windows only)
2. Docker (Desktop)

### Windows Subsystem for Linux

Install [WSL2][wsl_install] on the enabler the _Hyper V_ virtualization.

### Docker 

Installed [Docker Desktop][desktop] to test the hosting of the IT department.

## Drupal

Using the example of `docker compose` for installing Drupal with MySQL.

During the configuration, the database hostname is _db_ not _localhost_ in the _advanced_ options.

[wsl_install]: https://docs.microsoft.com/en-us/windows/wsl/install-win10 "WSL2 Install"
[desktop]: https://www.docker.com/products/docker-desktop "Docker Desktop"
