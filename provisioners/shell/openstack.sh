#!/bin/bash

HOME_DIR="/home/vagrant"
WORKING_DIR="/tmp"

echo "********** Start installing openstack tools **********"

echo "+++++ Installing pip"

yum install -y python-devel python-pip

pip install --upgrade pip

pip install python-openstackclient virtualenvwrapper

echo "********** Finished installing openstack tools **********"
