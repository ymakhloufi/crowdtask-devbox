#!/usr/bin/env bash
sudo pip install ansible
mkdir /etc/ansible -p
cp /home/vagrant/ansible/inventory/dev /etc/ansible/hosts -f
chmod 666 /etc/ansible/hosts
cat /home/vagrant/share/authorized_keys >> /home/vagrant/.ssh/authorized_keys
sudo  /usr/local/bin/ansible-playbook /vagrant/ansible/playbook.yml --connection=local