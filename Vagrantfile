# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Global Settings
  config.vm.box      = "puppetlabs/ubuntu-14.04-64-nocm"
  config.vm.box_url  = "https://atlas.hashicorp.com/puppetlabs/boxes/ubuntu-14.04-64-nocm/versions/1.0.3/providers/virtualbox.box"
  config.vm.provider "virtualbox" do |v|
    v.memory = 256
  end
  
  vms = [
    { :name => "app1", :ip => "172.16.1.11", :role => 'helloapp' },
    { :name => "app2", :ip => "172.16.1.12", :role => 'helloapp' },
    { :name => "lb", :ip => "172.16.1.10", :role => 'loadbalancer', :portmp => [{:guest => 80, :host => 8080}]}
  ]
  
  # VM definitions
  vms.each do |vm|
    config.vm.define vm[:name] do |config|
	  config.vm.hostname = vm[:name]
	  config.vm.network :private_network, ip: vm[:ip]
	  if vm[:portmp] and vm[:portmp].is_a?(Array)
	    vm[:portmp].each do |mp|
		  if mp.keys&[:guest, :host] == [:guest, :host]
		    config.vm.network "forwarded_port", guest: mp[:guest], host: mp[:host]
		  end
		end
	  end
	  # Install Puppet Agent On Guest VMs
	  config.vm.provision "shell", path: "provisioning/shell/init.sh"
	  # Start Puppet provisioning
	  config.vm.provision "puppet" do |puppet|
	    #puppet.options = "--verbose --debug"
	    puppet.facter = {
          "role" => "#{vm[:role]}"
        }
		puppet.environment_path = "provisioning/puppet/environments"
        puppet.environment = "production"
		puppet.hiera_config_path = "provisioning/puppet/hiera.yaml"
		puppet.working_directory = "/vagrant/provisioning/puppet"
	  end
	end
  end

end