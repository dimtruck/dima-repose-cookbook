require 'chefspec'
require_relative 'spec_helper'

describe 'dima-repose::endpoint' do
  before { stub_resources }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(UBUNTU_OPTS).converge(described_recipe)
  end

  it 'includes the `runit` recipe' do
    expect(chef_run).to include_recipe('runit2')
  end

  it 'installs gunicorn python package' do
    expect(chef_run).to install_python_package('gunicorn')
  end

  # it 'installs httpbin python package' do
  #   expect(chef_run).to install_python_package('httpbin')
  # end

  # it 'installs python 2' do
  #   expect(chef_run).to install_python_runtime('2')
  # end

  it 'sets up gunicorn-service runit service' do
    expect(chef_run).to enable_runit_service('gunicorn-service')
  end
end
