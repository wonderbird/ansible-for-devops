# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.ssh.insert_key = false
  config.ssh.private_key_path = ["./ssh_user_key/id_ecdsa"]
  
  config.vm.synced_folder ".", "/vagrant", disabled: true
  
  config.vm.provider "docker" do |d|
    d.build_dir = "."
    d.dockerfile = "Dockerfile.Fedora"
    d.create_args = ["--privileged"]
    d.has_ssh = true
  end

  # Application server 1
  config.vm.define "app1" do |app1|
    app1.vm.hostname = "app1"
    app1.vm.network :private_network, ip: "192.168.56.4"
    app1.vm.network :forwarded_port, guest: 22, host: 2223, id: "ssh", auto_correct: true
  end

  # Application server 2
  config.vm.define "app2" do |app2|
    app2.vm.hostname = "app2"
    app2.vm.network :private_network, ip: "192.168.56.5"
    app2.vm.network :forwarded_port, guest: 22, host: 2224, id: "ssh", auto_correct: true
  end

  # Database server
  config.vm.define "db1" do |db1|
    db1.vm.hostname = "db1"
    db1.vm.network :private_network, ip: "192.168.56.6"
    db1.vm.network :forwarded_port, guest: 22, host: 2225, id: "ssh", auto_correct: true
  end
end
