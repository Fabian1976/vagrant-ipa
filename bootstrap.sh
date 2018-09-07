#!/bin/bash
#install epel repo
yum -y localinstall https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#install entropy agent
yum install -y haveged
systemctl start haveged
systemctl enable haveged

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
echo "10.10.10.110 katello.vermont24-7.local" >> /etc/hosts

#install vim
yum install -y vim
echo "alias vi='vim'" >> /etc/profile

#install git and puppet vim syntax highlighting
yum install -y git
mkdir -p /root/.vim
git clone https://github.com/rodjek/vim-puppet.git /root/.vim/

#Install puppet repo
yum -y localinstall http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
#http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
#Install puppet
yum -y install puppet-agent

#Apply puppet manifest
/opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp
