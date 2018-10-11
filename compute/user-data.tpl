#/bin/bash
sudo yum -y update
sudo yum install -y git,wget
sudo wget https://packages.chef.io/files/stable/chef/14.5.33/el/6/chef-14.5.33-1.el6.x86_64.rpm
rpm -ivh chef-*


