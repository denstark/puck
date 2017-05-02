Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end
  config.vm.hostname = "puck"
  config.vm.box = "centos/7"
  config.vm.provision "shell", path: "provisioner.sh"
end
