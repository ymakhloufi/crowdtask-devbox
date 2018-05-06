Required System Packages:

    vagrant
    virtualbox
    ansible

Required Vagrant plugins:

    vagrant plugin install vagrant-hostmanager
    vagrant plugin install vagrant-disksize


Patch the bundler.rb file if plugin-installation of vagrant-triggers fails due to some ruby errors (e.g. under Ubuntu 16.04):
  `sudo sed -i'' "s/Specification.all = nil/Specification.reset/" /usr/lib/ruby/vendor_ruby/vagrant/bundler.rb`

In order to bootstrap the whole thing, just run ```vagrant up --provision``` while you are in the folder with the cloned dev-box repository.

Ansible should install everything 

