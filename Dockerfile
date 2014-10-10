# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/passenger-customizable:latest

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# If you're using the 'customizable' variant, you need to explicitly opt-in
# for features. Uncomment the features you want:
#
#   Build system and git.
RUN /build/utilities.sh
#   Ruby support.
#RUN /build/ruby1.9.sh
#RUN /build/ruby2.0.sh
RUN /build/ruby2.1.sh
#   Python support.
#RUN /build/python.sh
#   Node.js and Meteor support.
#RUN /build/nodejs.sh

# Opt-in for Redis if you're using the 'customizable' image.
RUN /build/redis.sh

# Enable the Redis service.
RUN rm -f /etc/service/redis/down

# Opt-in for Memcached if you're using the 'customizable' image.
RUN /build/memcached.sh

# Enable the memcached service.
RUN rm -f /etc/service/memcached/down

# ...put your own build instructions here...

# passenger + apache https://www.phusionpassenger.com/documentation/Users%20guide%20Apache.html#install_on_debian_ubuntu
# setting ENV here may cause trouble, see https://docs.docker.com/reference/builder/
#RUN export DEBIAN_FRONTEND=noninteractive # will it work? https://github.com/phusion/baseimage-docker/issues/58

# Passenger
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
RUN sudo apt-get install -y apt-transport-https ca-certificates
ADD passenger.list /etc/apt/sources.list.d/passenger.list
RUN sudo chown root: /etc/apt/sources.list.d/passenger.list
RUN sudo chmod 600 /etc/apt/sources.list.d/passenger.list
RUN sudo apt-get update
RUN sudo apt-get install -y libapache2-mod-passenger
RUN sudo a2enmod passenger
RUN sudo service apache2 restart

# freetds
sudo apt-get install freetds-dev freetds-bin tdsodbc

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# init process
RUN mkdir /etc/service/apache2
ADD apache2/silent.sh /sbin/apache2silent
ADD apache2/run.sh /etc/service/apache2/run

