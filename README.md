Required System Packages:

    vagrant
    virtualbox
    ansible

Required Vagrant plugins:

    vagrant plugin install vagrant-hostmanager
    vagrant plugin install vagrant-disksize

In order to bootstrap the whole thing, git-clone crowdtask into the /code/ folder:

    cd code
    git clone git@github.com:ymakhloufi/crowdtask-devbox.git

Then just run ```vagrant up --provision``` while you are in the folder with the cloned dev-box repository.

Ansible should install everything 

