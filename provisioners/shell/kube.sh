#!/bin/bash

HOME_DIR="/home/vagrant"
WORKING_DIR="/tmp"
BASH_PROFILE=$HOME_DIR/.bash_profile


install_kubectl () {
	echo "+++++ Installing kubectl"

	cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

	yum install -y kubectl
}

install_virtualbox () {
	echo "+++++ Installing virtualbox"
	
	if ! yum list installed |grep -i virtualbox; then
		wget https://download.virtualbox.org/virtualbox/5.2.22/VirtualBox-5.2-5.2.22_126460_el7-1.x86_64.rpm
	
		yum install -y VirtualBox-5.2-5.2.22_126460_el7-1.x86_64.rpm

		rm -f VirtualBox-5.2-5.2.22_126460_el7-1.x86_64.rpm	
	fi
}

install_minikube () {
	echo "+++++ Installing minikube"

	if ! minikube version; then
		curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.30.0/minikube-linux-amd64 && chmod +x minikube && cp minikube /usr/local/bin/ && rm minikube
	fi
}

echo "********** Start provisioning kubernetes packages **********"

install_kubectl

install_virtualbox

install_minikube

echo "********** Finished provisioning kubernetes packages **********"


