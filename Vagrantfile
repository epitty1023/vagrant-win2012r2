# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "windows2012"
  config.vm.box_url = "https://s3.amazonaws.com/GCC_vagrant/windows_2012_r2_virtualbox.box"
  config.vm.guest = :windows
 
# Configure 2GB (2048MB) of memory, 2vCPU and add a secondary hard drive 60Gb
  config.vm.provider :virtualbox do |vb|
  vb.gui = true
  vb.customize ["modifyvm", :id, "--memory", 2048]
  vb.customize ["modifyvm", :id, "--cpus", "2"]
  #file_to_disk = './tmp/large_disk.vdi'
  #vb.customize ['createhd', '--filename', file_to_disk, '--size', 60 * 1024]
  #vb.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
  
end
  
  config.vm.define :local do |config|
  config.vm.hostname = "vagrant-vm"
  config.vm.network :private_network, ip: "10.60.60.10"
  config.vm.network :forwarded_port, guest: 22, host: 2131
  config.ssh.forward_agent = true
  config.vm.network :forwarded_port, guest: 3389, host: 3377, id: "rdp", auto_correct: false
  config.vm.network :forwarded_port, guest: 80, host: 8080, id: "web", auto_correct: false
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
  config.windows.set_work_network = true
  config.winrm.max_tries = 10
 
# sync the folders you want (generally the SVN root)
  config.vm.synced_folder "wwwroot", "c:\inetpub\wwwroot"

# Provisioning Secondary Disk
  #config.vm.provision :shell, path: "scripts/formatDdisk.ps1"

# Installing Puppet:
  config.vm.provision :shell, path: "scripts/Install-Puppet.ps1"
  
# Enable remoting in, useless if you uncommented "v.gui = true" above
   config.vm.provision :shell, path: "scripts/Enable-RDP.ps1"
   
# Disable Firewall
  config.vm.provision :shell, path: "scripts/disablefirewall.ps1" 

# Install AWS Powelshell Tools
  config.vm.provision :shell, path: "scripts/AWSPowerShellTool.ps1"

# Configure Puppet client in local VM
  config.vm.provision :puppet do |puppet|
  puppet.facter = {
  "hostuser" => ENV['USERNAME']
  }
	puppet.manifests_path = "puppet/manifests"
  puppet.manifest_file = "init.pp"
	puppet.module_path = "puppet/modules"
  puppet.options = "--verbose --debug"

  end
 end
end
