passenger-ruby21-apache2
========================

Docker build for passenger-ruby21-apache2.

To build, run:

    sudo docker build -t denispeplin/passenger-ruby21-apache .

To push, run:

    sudo docker push denispeplin/passenger-ruby21-apache

To pull, run:

    sudo docker pull denispeplin/passenger-ruby21-apache

To look around in the image, run:

    docker run --rm -t -i denispeplin/passenger-ruby21-apache bash -l

To prepare apache2 folder:
    docker cp <IMAGE_ID>:/etc/apache2 /etc/

To run container in background:

    /bin/mkdir -p /var/lib/gems && \
      /usr/bin/docker run -d --net host \
      -v /var/lib/gems:/var/lib/gems -v /opt:/opt -v /etc/apache2:/etc/apache2 \
      -v /etc/ssl:/etc/ssl -v /mnt:/mnt -v /etc/localtime:/etc/localtime \
      denispeplin/passenger-ruby21-apache

Put this command to /etc/rc.local

It'll output docker container ID to console.

To login into container from Docker host, use `docker-bash` tool.

First, install it:

  curl --fail -L -O https://github.com/phusion/baseimage-docker/archive/master.tar.gz && \
    tar xzf master.tar.gz && \
    sudo ./baseimage-docker-master/install-tools.sh

Then login to running container:

  docker-bash YOUR-CONTAINER-ID

By default, `docker-bash` will open a Bash session.

Deployment:

Workaround:
To install everything install into docker container directly, `Capistrano`'s `config/deploy.rb`
must be heavily modified. To avoid this, and run some commands on Docker host, run
`scp host-install.sh <DOCKER_HOST>:` and execite it there.

* Run `chsh www-data -s /bin/sh`
* Fill in with your public key `~www-data/.ssh/authorized_keys` on Docker host.
* Put www-data git public and private keys to `~www-data/.ssh/`
* Login to Docker host, run `su - www-data` and `ssh YOUR-GIT-REPO` to establish host key.
* Create top-level project directory in `/opt` with permissions assigned to `www-data`.
* Allow www-data on Docker host, run: `echo "www-data ALL=NOPASSWD: /usr/local/bin/bundle" >>/etc/sudoers`

