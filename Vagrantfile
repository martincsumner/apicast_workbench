# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
  config.vm.provider "virtualbox" do |v|
  	v.memory = 4096
  	v.cpus = 2
end
  config.vm.network :forwarded_port, guest: 80, host: 9980
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/", group:'vagrant', owner:'vagrant', mount_options: ["dmode=777","fmode=666"]
  config.vm.hostname = "proxy.vagrant.vm"
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "master.yml"
    #ansible.playbook = "develop.yml"
    ansible.sudo = true
    ansible.limit = 'all'
  end
end
