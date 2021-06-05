#
# Create a container with PHP to install the "storage finder module."
#
FROM drupal:8.9.15-php7.4-apache-buster
RUN apt-get update; apt-get -y --no-install-recommends install unzip git
ENV TZ="Asia/Riyadh"