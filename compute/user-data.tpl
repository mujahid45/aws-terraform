#!/bin/bash
yum -y update
yum install wget
cd /tmp
wget https://packages.chef.io/files/stable/chef/14.5.33/el/7/chef-14.5.33-1.el7.x86_64.rpm
rpm -ivh chef-*
yum install git -y
git clone https://github.com/rajeswari1203/test-cookbook.git
cd test-cookbook/chef-repo
chef-solo -c solo.rb