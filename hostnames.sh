# My try at configuring passwordless ssh
# cat /vagrant/hosts.cfg >> /etc/hosts
mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
sudo cp /etc/ssh/ssh_host_rsa_key /home/vagrant/.ssh/id_rsa
sudo chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
chmod 600 /home/vagrant/.ssh/id_rsa
cp /vagrant/authorized_keys /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
cp /vagrant/known_hosts /home/vagrant/.ssh/known_hosts
chmod 644 /home/vagrant/.ssh/known_hosts
chown -R vagrant:vagrant /home/vagrant/.ssh
