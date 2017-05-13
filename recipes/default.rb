#
# Cookbook Name:: dima-repose
# Recipe:: default
#
# Copyright (C) 2017 Dimitry Ushakov
#

include_recipe 'java::oracle'
include_recipe 'repose::install'

repose_creds = Chef::EncryptedDataBagItem.load('passwords', 'repose')

node.override['repose']['keystone_v2']['uri'] = repose_creds['uri']
node.override['repose']['keystone_v2']['username_admin'] = repose_creds['user']
node.override['repose']['keystone_v2']['password_admin'] = repose_creds['pass']

include_recipe 'repose::filter-header-normalization'
include_recipe 'repose::filter-keystone-v2'
include_recipe 'repose::filter-url-extractor-to-header'
include_recipe 'repose'

# ensure package init script is removed to avoid confusion
file '/etc/init.d/repose-valve' do
  action :delete
end

if node.chef_environment == 'dev'
  node.default['repose']['jvm_minimum_heap_size'] = '1g'
  node.default['repose']['jvm_maximum_heap_size'] = '1g'
  node.default['repose']['jvm_maximum_file_descriptors'] = '16384'
end

template '/etc/init/repose-valve.conf' do
  source 'repose-valve.upstart.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'repose-valve' do
  supports restart: true, status: true
  action %i[enable start]
  provider Chef::Provider::Service::Upstart
end
