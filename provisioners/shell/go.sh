#!/bin/bash

HOME_DIR="/home/vagrant"
WORKING_DIR="/tmp"
BASH_PROFILE=$HOME_DIR/.bash_profile

install_go () {
	echo "+++++ Installing go 1.11.2"

	wget -q https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz
	tar -C /usr/local -xzf go1.11.2.linux-amd64.tar.gz
	rm go1.11.2.linux-amd64.tar.gz

	mkdir -p $HOME_DIR/go/bin

	#
	echo "+++++ Configure .bash_profile for go"

	if ! grep -q 'go\/bin' $BASH_PROFILE; then
	    cat <<EOF >> $HOME_DIR/.bash_profile

if [ -d "/usr/local/go/bin" ] ; then
    PATH="/usr/local/go/bin:\$PATH"
fi

if [ -d "\$HOME/go/bin/" ] ; then
   PATH="\$HOME/go/bin/:\$PATH"
fi

export PATH

export GOPATH=\$HOME/go
EOF
	fi
}

echo "********** Start provisioning go packages **********"

echo "+++++ Installing yum packages"

yum install -y wget

cd $WORKING_DIR

GO_VERSION=$(sudo -i -u vagrant go version | cut -f 3 -d " ")
if [ "$GO_VERSION" == "go1.11.2" ]; then
	echo "go 1.11 exists, skip installation"
else
	install_go
fi

echo "********** Finished provisioning go packages **********"


