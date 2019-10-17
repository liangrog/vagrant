#!/bin/bash

HOME_DIR="/home/vagrant"
WORKING_DIR="/tmp"
BASH_PROFILE=$HOME_DIR/.bash_profile
USER="vagrant"
VERSION="1.13"

install_go () {
	echo "+++++ Installing go $VERSION"

	wget -q "https://dl.google.com/go/go$VERSION.linux-amd64.tar.gz"
	tar -C /usr/local -xzf "go$VERSION.linux-amd64.tar.gz"
	rm "go$VERSION.linux-amd64.tar.gz"

	sudo -u $USER mkdir -p $HOME_DIR/go/bin

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
if [ "$GO_VERSION" == "go$VERSION" ]; then
	echo "go $VERSION exists, skip installation"
else
	install_go
fi

echo "********** Finished provisioning go packages **********"


