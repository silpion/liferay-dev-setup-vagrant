# Setup prototype for Liferay development with Vagrant

This project contains the Vagrant project that creates a VM, provisioned with a
Liferay server and it's prerequisites. Provisioning is performed using an
_Ansible_ playbook. It installs:

* a _MySQL_ database
* a _Java 7_ JDK
* a _Liferay 6.2_ Tomcat bundle.

The packages for _MySQL_ and _Java_ are installed using _Aptitude_. Local
caching for (many of) those packages is prepared. It is activated when the
_Vagrant_ plugin ```vagrant-cachier``` is installed.

The packages for the Liferay system are downloaded from configurable locations.
They are cached in the directory `.ansible/cache/download`.

The auto deploy directory of the Liferay server is accessible from outside the
VM, so that each (developed) Liferay extension can be deployed only by copying
its `*.war` archive to that directory.


## Prerequisites

Starting and provisioning the VM requires the following software packages to be
installed:

* [Vagrant](http://vagrantup.com)
* [Ansible](http://www.ansibleworks.com)


## Starting and using the VM

See [Vagrant Documentation](http://docs.vagrantup.com) how to work with Vagrant.
Important commands are:

    vagrant up
    vagrant provision
    vagrant halt
    vagrant destroy


## Using the VM

After the VM is successfully started and provisioned, open
[http://localhost:18080/](http://localhost:18080/) in a browser and follow the
requested steps. Sign in with the default admin user:
* Email Address: `test@liferay.com`
* Password: `test`


## Extension development

The extension development might e.g. be organised in a *Maven* (multi module)
project. It should be configured with the path to the auto deploy directory.

See _Setup prototype for Liferay development with Maven_.


## Server setup with Ansible

The Ansible playbook, that is used to provision the Vagrant VM, can also be used
to set up the Liferay system (including MySQL and Java) on other environments
(servers), too. For each additional environment, an inventory file
```provisioning/inventory_[environment]``` has to be created. Replicate an
existing inventory file and adjust its contents regarding to the new environment
and/or see the documentation on the Ansible home page:
[Ansible Docs - Inventory](http://docs.ansible.com/intro_inventory.html).
If the new environment requires custom configurations, create a file
```provisioning/host_vars/[environment].yml``` and configure the variables that
should be overwritten.

To run the setup call:

    ansible-playbook provisioning/playbook.yml \
                     -i provisioning/inventory_[environment]

### Variables for Liferay version

The default variables define the (currently) latest version of the Liferay
Community Edition for installation. If a server should be set up with another
edition/version, those variables can be overwritten, e.g. in the regarding
```provisioning/host_vars/[environment].yml``` file for the server to be set up.
Prefedined variables for known editions can be found in the directory
```provisioning/roles/liferay/edition_vars``` and can simply be copied to the
```provisioning/host_vars/[environment].yml``` file.


## TODOs / Improvements

TODOs and improvments for this setup:

* The file ```provisioning/roles/mysql/tasks/main.yml``` defines a task
  _ensure root access_, that provides access rights to the _root_ user, so that
  the database and the database user can be for the _Liferay_ system can be
  created by the _Ansible_ scripts. The current solution for this task is good
  enough to set up a _Vagrant_ VM, but it shouldn't be used to set up a
  productive or any other system, that is accessible from the internet.
* The setup of the Tomcat service is not properly implemented, it normally
  should work with ```daemon.sh``` and ```jsvc```. That setup caused many
  problems and we decided to do a first attempt with a custom ```service.sh```
  script, that simply invokes Tomcat's ```catalina.sh```. It's not 100% stable
  but basically seems to work. Anyway, we should rather implement a proper
  solution with ```daemon.sh``` and ```jsvc```.
* Avoid Liferay installation if ```{{liferay_home_dir}}``` already exists.
* Add more ```provisioning/roles/liferay/edition_vars/liferay-[VERSION].yml```
  files for further known Liferay editions.

Pull requests addressing any of those TODOs are very welcome!
