#!/bin/bash

HOME_DIR="/home/vagrant"
WORKING_DIR="/tmp"

echo "********** Start provisioning core **********"

#
echo "+++++ Installing yum packages"

yum install -y wget git


echo "********** Finished provisioning core **********"
