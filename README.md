passenger-ruby21-apache2
========================

Docker build for passenger-ruby21-apache2.

To look around in the image, run:

    docker run --rm -t -i denispeplin/passenger-ruby21-apache bash -l

To run container in background:

    docker run -d --net host denispeplin/passenger-ruby21-apache

It'll output docker container ID to console.

To login into container from Docker host, use `docker-bash` tool.

First, install it:

  curl --fail -L -O https://github.com/phusion/baseimage-docker/archive/master.tar.gz && \
    tar xzf master.tar.gz && \
    sudo ./baseimage-docker-master/install-tools.sh

Then login to running container:

  docker-bash YOUR-CONTAINER-ID

By default, `docker-bash` will open a Bash session.
