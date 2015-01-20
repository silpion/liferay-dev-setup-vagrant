# 0.3

Marc Rohlfs (7):

* Properly activate vagrant-cachier.
* Document passwordless sudo requirement on local host.
* Forward default port 8080 instead of 18080 into Vagrant VM.
* Updated submodule ansible/roles/liferay to version 0.3.1.
* Updated submodule ansible/roles/java to version 0.7.
* Sample inventory to set up server environments.
* Applied README to all the latest changes

# 0.2.1

Marc Rohlfs (1):

* Enable remote debugging for Liferay Tomcat server in running in the Vagrant VM.

# 0.2

Marc Rohlfs (10):

* Renamed base folder for Ansible provisioning from 'provisioning' to 'ansible'.
* Applied new Vagrant box allocation mechanism.
* The inventory for ahead-relaunch-dev.office.silpion.de should not be in the skeleton.
* Define the Vagrant settings in group_vars instead of host_vars and ensure that the Vagrant inventory can only be used when Ansible is executed by Vagrant.
* Applied definition of Ansible variable for downloaded or templated data to current Silpion best practice.
* Rather define all required roles in the playbook than declaring role dependencies.
* The sudo user should explicitly be defined.
* Replaced inline Java role with submodule and ensured that a Java 7 JDK is installed and that the 'JAVA_HOME' environment variable is properly set when starting the Liferay service.
* Replaced inline MySQL role with submodule (galaxy) and ensured configured it with the default database and user for the Liferay server.
* Replaced inline Liferay role with new submodule, using its default configuration.

# 0.1

Marc Rohlfs (2):

* Vagrant VM for the Liferay development (e.g. with Maven), provisioned with a MySQL database and a Liferay 6.2 Tomcat bundle.
* Variables defined in the 'vars_files' cannot be overwritten by those defined in the 'host_vars'. To allow proper default and overwriting variables for the expected cases, the variables that define the Liferay edition to be installed are define in the roles' defaults and might be overwritten e.g. in the 'host_vars'. Examples for the known editions are provided in the '...roles/liferay/edition_vars' directory.
