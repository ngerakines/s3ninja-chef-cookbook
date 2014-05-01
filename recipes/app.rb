#
# Cookbook Name:: s3ninja
# Recipe:: app
#
# Copyright (C) 2014 Nick Gerakines <nick@gerakines.net>
# 
# This project and its contents are open source under the MIT license.
#

include_recipe 'apt'
include_recipe 'yum'

node.default['java']['jdk_version'] = 7

include_recipe 'java'

user 's3ninja' do
  username 's3ninja'
  home '/home/s3ninja'
  action :remove
  action :create
  supports ({ :manage_home => true })
end

group 's3ninja' do
  group_name 's3ninja'
  members 's3ninja'
  action :remove
  action :create
end

package 'unzip' do
	action :install
end

package 'curl' do
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/s3ninja.zip" do
  source node[:s3ninja][:package_source]
end

bash 'extract_app' do
  cwd '/home/s3ninja/'
  code <<-EOH
    unzip #{Chef::Config[:file_cache_path]}/s3ninja.zip
    EOH
  not_if { ::File.exists?('/home/s3ninja/sirius.sh') }
end

execute 'chown -R s3ninja:s3ninja /home/s3ninja/'

file '/home/s3ninja/sirius.sh' do
  mode 00777
end

cookbook_file '/home/s3ninja/upload.sh' do
  source 'upload.sh'
  mode 00777
end

cookbook_file '/home/s3ninja/get.sh' do
  source 'get.sh'
  mode 00777
end
