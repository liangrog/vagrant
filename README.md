# Vagrant
Vagrant files for environments

All provisioning files are located in directory `provisioners`.

All environment specifc vagrant files are located in directory `env`.

## Notes

### NFS issue with network dhcp
You might encounter vagrant error `No guest IP was given to the Vagrant core NFS helper` when using NFS mount to host machine. It can be resolved without using static IPs by running:
```shell
vagrant plugin install vagrant-vbguest
```
If your box has been created before the plugin is installed, you will need to run `vagrant halt` then `vagrant up` again.

Details could be found in [vagrant issue](https://github.com/hashicorp/vagrant/issues/7070)
