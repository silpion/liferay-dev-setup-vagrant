# Liferay Skeleton

This project contains an Ansible playbook to set up a *Liferay Portal* server.
It can either be used to set up a test, stage, production or any other
environment, as well as provisioning a Vagrant VM for development purposes.

Setup/provisioning includes the installation of a *Liferay Portal* server and
its prerequisites:

* a _MySQL_ database
* a _Java 7_ JDK
* a _Liferay 6.2_ Tomcat bundle.

## Prerequisites

Starting and provisioning the VM requires the following software packages to be
installed:

* [Vagrant](http://vagrantup.com) (Only for dev environment with Vagrant)
* [Ansible](http://www.ansibleworks.com)

**Please note** that the download tasks in (some of) the role submodules require
passwordless sudo on Your local host, because the archives are cached a
directory, that normally isn't beyond user access (see `local_ansible_data_path`
configuration).

## Development environment with Vagrant

With the provided default configuration for the development environment with
Vagrant, the auto deploy directory of the *Liferay Portal* server is accessible
from outside the VM, so that each (developed) extension can be deployed only by
copying its `*.war` archive to that directory.

### Starting and using the VM

See [Vagrant Documentation](http://docs.vagrantup.com) how to work with Vagrant.
Important commands are:

    vagrant up
    vagrant provision
    vagrant halt
    vagrant destroy


### Using the VM

After the VM is successfully started and provisioned, open
[http://localhost:8080/](http://localhost:8080/) in a browser and follow the
requested steps. Sign in with the default admin user:
* Email Address: `test@liferay.com`
* Password: `test`

If an enterprise edition of the *Liferay Portal* server is installed, a file
containing a valid license has to be provided. It can simply be copied into the
*liferay-deploy* directory and the server will automatically apply it.

### Extension development

The extension development might e.g. be organised in a *Maven* (multi module)
project. It should be configured with the path to the *liferay-deploy* directory.

## Server setup with Ansible

The Ansible playbook, that is used to provision the Vagrant VM, can also be used
to set up the Liferay system (including MySQL and Java) on other environments
(servers), too. For each additional environment, an inventory file
```ansible/inventory/[environment]``` has to be created. Replicate an existing
inventory file and adjust its contents regarding to the new environment and/or
see the documentation on the Ansible home page:
[Ansible Docs - Inventory](http://docs.ansible.com/intro_inventory.html).
If the new environment requires custom configurations, create a file
```ansible/host_vars/[environment].yml``` and configure the variables that
should be overwritten.

To run the setup call:

    ansible-playbook ansible/playbook.yml \
                     -i ansible/inventory/[environment]

### Variables for Liferay version

The default variables define the (currently) latest version of the *Liferay
Portal* server for installation. If a server should be set up with another
version, those variables can be overwritten, e.g. in the regarding
```ansible/host_vars/[environment].yml``` file for the server to be set up.
Prefedined variables for known versions can be found in the directory
```ansible/roles/liferay/vars/versions``` and can simply be overwritten in
the ```ansible/host_vars/[environment].yml``` file.
