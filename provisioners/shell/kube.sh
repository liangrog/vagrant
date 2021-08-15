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

install_aws_iam_authenticator () {
	echo "+++++ Installing aws-iam-authenticator 1.14.6"

	curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator
	
	chmod +x ./aws-iam-authenticator

	mv aws-iam-authenticator /usr/local/bin/
}

install_helm () {
	echo "+++++ Installing helm v3.2.4"

	curl -o helm.tar.gz https://get.helm.sh/helm-v3.2.4-linux-amd64.tar.gz
	tar -zxvf helm.tar.gz
	mv linux-amd64/helm /usr/local/bin/helm
        rm -rf helm.tar.gz linux-amd64
}

install_kubebuilder () {
	echo "+++++ Installing kubebuilder v2.2.0"
	
	os="linux"
	arch="amd64"

	# download kubebuilder and extract it to tmp
	curl -sL https://go.kubebuilder.io/dl/2.2.0/${os}/${arch} | tar -xz -C /tmp/

	# move to a long-term location and put it on your path
	# (you'll need to set the KUBEBUILDER_ASSETS env var if you put it somewhere else)
	mv /tmp/kubebuilder_2.2.0_${os}_${arch} /usr/local/kubebuilder
	
	# Use local kubectl
	rm /usr/local/kubebuilder/bin/kubectl

	if ! grep -q 'kubebuilder\/bin' $HOME_DIR/.bash_profile; then
	if ! [ -x "$(command -v kubebuilder)" ]; then
	cat <<EOF >> $HOME_DIR/.bash_profile
export PATH="/usr/local/kubebuilder/bin:\$PATH"	
EOF
	fi
	fi
}

#install_virtualbox () {
#	echo "+++++ Installing virtualbox"
#	
#	if ! yum list installed |grep -i virtualbox; then
#		wget https://download.virtualbox.org/virtualbox/5.2.22/VirtualBox-5.2-5.2.22_126460_el7-1.x86_64.rpm
#	
#		yum install -y VirtualBox-5.2-5.2.22_126460_el7-1.x86_64.rpm
#
#		rm -f VirtualBox-5.2-5.2.22_126460_el7-1.x86_64.rpm	
#	fi
#}

#install_minikube () {
#	echo "+++++ Installing minikube"
#
#	if ! minikube version; then
#		curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.30.0/minikube-linux-amd64 && chmod +x minikube && cp minikube /usr/local/bin/ && rm minikube
#	fi
#}

echo "********** Start provisioning kubernetes packages **********"

install_kubectl

#install_aws_iam_authenticator

install_helm

#install_kubebuilder

#install_virtualbox

#install_minikube

echo "********** Finished provisioning kubernetes packages **********"


