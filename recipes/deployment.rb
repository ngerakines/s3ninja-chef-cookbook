#
# Cookbook Name:: s3ninja
# Recipe:: deployment
#
# Copyright (C) 2014 Nick Gerakines <nick@gerakines.net>
# 
# This project and its contents are open source under the MIT license.
#

template '/etc/init.d/s3ninja' do
  source 's3ninja-init.erb'
  mode 0777
  owner 'root'
  group 'root'
end

service 's3ninja' do
  provider Chef::Provider::Service::Init
  action [:start]
end
