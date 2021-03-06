# Vagrant
Vagrant files for bootstrapping environments.

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

### Recover from accidental deletion of .vagrant directory
1. Given the vbox in virturlBox still exists, run below cmd to find the ID of the vbox and replace the `.vagrant/machines/default/virtualbox/id` with the new ID
```
vboxmanage list vms 
```
2. Bootup the vbox and ssh into the box with `vagrant ssh` using password `vagrant`. Then get the default vagrant ssh pub and add it into `authorized_keys`
```
wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -a .ssh/authorized_keys
```
3. Reload the vbox.

### Failed to mount NFS share folder after changing folder path
```
==> default: Exporting NFS shared folders...
NFS is reporting that your exports file is invalid. Vagrant does
this check before making any changes to the file. Please correct
the issues below and execute "vagrant reload":

exports:2: path contains non-directory or non-existent components: /Users/<username>/path/to/vagrant
exports:2: no usable directories in export entry
exports:2: using fallback (marked offline): /
exports:5: path contains non-directory or non-existent components: /Users/<username>/path/to/vagrant
exports:5: no usable directories in export entry
exports:5: using fallback (marked offline): /
```
To fix, remove related vagrant entry in `/etc/exports`
