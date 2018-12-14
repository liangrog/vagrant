#!/bin/bash

HOME_DIR="/home/vagrant"
WORKING_DIR="/tmp"
BASH_PROFILE=$HOME_DIR/.bash_profile
DOCKER_USER="vagrant"

clean_up_old_docker () {
	echo "+++++ Clean up old docker"
	yum remove docker \
	  docker-client \
	  docker-client-latest \
	  docker-common \
	  docker-latest \
	  docker-latest-logrotate \
	  docker-logrotate \
	  docker-selinux \
	  docker-engine-selinux \
	  docker-engine
}

prepare_docker () {
	echo "+++++ Prepare docker installation tools"
	yum install -y yum-utils \
  		device-mapper-persistent-data \
  		lvm2

	yum-config-manager \
    		--add-repo \
    		https://download.docker.com/linux/centos/docker-ce.repo
}

install_docker () {
	echo "+++++ Installing docker"
	yum install -y docker-ce
	groupadd docker
	usermod -aG docker $DOCKER_USER
	systemctl start docker
	systemctl enable docker
}

echo "********** Start provisioning docker CE**********"

clean_up_old_docker

prepare_docker

install_docker

echo "********** Finished provisioning docker CE **********"


