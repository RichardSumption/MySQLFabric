VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
   # General config
   config.vm.box = "RichardSumption/Centos65fabricbase"
   config.vm.synced_folder "hieradata", "/var/lib/hiera"

   CONTROLIP = "172.16.0.10"
   DATAIP    = "172.16.0.1"

   (1..3).each do |i|
      config.vm.define "data0#{i}" do |data|
         data.vm.provision "shell", path: "hostnames.sh"
         data.vm.network :private_network, ip: "#{DATAIP}#{i}",
            virtualbox__intnet: "mynet"
         data.vm.hostname = "data0#{i}"
         # Virtualbox configuration
         data.vm.provider "virtualbox" do |vb|
            vb.customize ["modifyvm", :id, "--memory", 512]
            vb.name = "Data0#{i}"
         end
         # Puppet provisioning
         data.vm.provision :puppet do |puppet|
            puppet.manifests_path = "manifests"
            puppet.module_path = "modules"
            puppet.hiera_config_path = "hiera.yaml"
            puppet.options = "--verbose"
         end
      end
   end

   # Controller node
   config.vm.define "control" do |control|
      control.vm.hostname = "fabric"
      # setup the network
      control.vm.provision "shell", path: "hostnames.sh"
      control.vm.network "private_network", ip: "#{CONTROLIP}",
            virtualbox__intnet: "mynet"
      # Virtualbox configuration
      control.vm.provider "virtualbox" do |vb|
         vb.customize ["modifyvm", :id, "--memory", 512]
         vb.name = "Fabric"
      end
      # Puppet provisioning
      control.vm.provision :puppet do |puppet|
         puppet.manifests_path = "manifests"
         puppet.module_path = "modules"
         puppet.hiera_config_path = "hiera.yaml"
         puppet.options = "--verbose"
      end
   end
end
