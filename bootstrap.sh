#!/bin/bash
#Disable networkmanager
systemctl stop NetworkManager
yum remove NetworkManager -y
yum remove firewalld -y
yum install iptables-services -y
#set correct timezone
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
#delete host as localhost
sed -i '1d' /etc/hosts
echo "10.10.10.110 katello.cmc.lan" >> /etc/hosts

#install vim
yum install -y vim
echo "alias vi='vim'" >> /etc/profile

#install git and puppet vim syntax highlighting
yum install -y git
mkdir -p /root/.vim
git clone https://github.com/rodjek/vim-puppet.git /root/.vim/

#install epel repo
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#Install puppet repo
yum -y install http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
#http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
#Install puppet
yum -y install puppet
#Remove default manifests and modules and replace them with the one from the vagrant share
rm -rf /etc/puppetlabs/code/environments/production/hieradata; ln -s /vagrant/puppet/hieradata /etc/puppetlabs/code/environments/production/hieradata
rm -rf /etc/puppetlabs/code/environments/production/manifests; ln -s /vagrant/puppet/manifests /etc/puppetlabs/code/environments/production/manifests
rm -rf /etc/puppetlabs/code/environments/production/modules; ln -s /vagrant/puppet/modules /etc/puppetlabs/code/environments/production/modules

#Apply puppet manifest
/opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp
