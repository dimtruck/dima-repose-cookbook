#
# Cookbook Name:: dima-repose
# Recipe:: default
#
# Copyright (C) 2017 Dimitry Ushakov
#

include_recipe 'repose::install'

repose_creds = Chef::EncryptedDataBagItem.load('passwords', 'repose')

node.override['repose']['keystone_v2']['uri'] = repose_creds['uri']
node.override['repose']['keystone_v2']['username_admin'] = repose_creds['user']
node.override['repose']['keystone_v2']['password_admin'] = repose_creds['pass']

include_recipe 'repose::filter-header-normalization'
include_recipe 'repose::filter-keystone-v2'
include_recipe 'repose::filter-url-extractor-to-header'
include_recipe 'repose'
