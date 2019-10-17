#!/bin/bash

HOME_DIR="/home/vagrant"
WORKING_DIR="/tmp"

echo "********** Start provisioning core **********"

#
echo "+++++ Installing yum packages"

yum install -y epel-release

yum update -y

yum install -y wget \
	git \
	cntlm \
	bind-utils \
	bash-completion \
	bash-completion-extras 


echo "********** Finished provisioning core **********"
