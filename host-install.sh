#!/bin/sh

sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get install -y --no-install-recommends build-essential git ruby2.1 ruby2.1-dev nodejs libxml2-dev libxslt1-dev imagemagick libmagickwand-dev libmysqlclient-dev libsqlite3-dev libpq-dev libqt4-webkit libqt4-dev libcurl4-openssl-dev zlib1g-dev
sudo apt-get install -y postgresql-client
#sudo apt-get install -y redis-server libhiredis-dev memcached apt-transport-https ca-certificates
apt-get install -y freetds-dev freetds-bin tdsodbc
