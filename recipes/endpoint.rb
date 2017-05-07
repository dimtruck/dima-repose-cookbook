#
# Cookbook Name:: dima-repose
# Recipe:: endpoint
#
# Copyright (C) 2017 Dimitry Ushakov
#

include_recipe 'runit'

python_runtime '2' do
  version '2.7'
end

python_package 'gunicorn'

python_package 'httpbin'

runit_service 'gunicorn-service' do
  log_template_name 'gunicorn-service'
  owner 'daemon'
  group 'daemon'
  options(
    servicename: 'gunicorn-service'
  )
end
