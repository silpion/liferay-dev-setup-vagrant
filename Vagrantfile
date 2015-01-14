# -*- mode: ruby -*-
# vi: set ft=ruby :

# Marc Rohlfs, Silpion IT-Solutions GmbH - rohlfs@silpion.de
# Liferay Server with MySQL database for local developement
# 2014-01-02

Vagrant::VERSION >= '1.1.0' and Vagrant.configure('2') do |config|

  config.vm.define :liferay do |liferay|

    liferay.vm.box = 'ubuntu/trusty64'

    liferay.vm.hostname = 'liferay'

    if Vagrant.has_plugin?("vagrant-cachier")
      liferay.cache.scope       = :box
      liferay.cache.auto_detect = true
    end

    liferay.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbook.yml"

      ansible.tags = ENV['ANSIBLE_TAGS']

      ansible.groups = {
        'vagrant' => ['liferay']
      }
      ansible.limit = 'vagrant'

    end

    liferay.vm.synced_folder "liferay-deploy", "/vagrant/liferay-deploy",
      mount_options: ["dmode=777,fmode=777"]

    liferay.vm.network :forwarded_port, guest: 8080, host: 8080
    liferay.vm.network :forwarded_port, guest: 8000, host: 8000

    liferay.vm.provider :virtualbox do |vb|
      vb.customize [
        'modifyvm', :id, '--name', 'liferay', '--memory', '2048', '--cpus', '1'
      ]
    end

  end

end
