require 'chefspec'
require_relative 'spec_helper'

describe 'dima-repose::default' do
  before { stub_resources }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(UBUNTU_OPTS).converge(described_recipe)
  end

  it 'creates a template /etc/repose/keystone-v2.cfg.xml' do
    expect(chef_run).to create_template(
      '/etc/repose/keystone-v2.cfg.xml'
    )
  end

  it 'populates /etc/repose/keystone-v2.cfg.xml with default attrs' do
    expect(chef_run).to render_file(
      '/etc/repose/keystone-v2.cfg.xml'
    ).with_content(include('username="secretdima"'))
    expect(chef_run).to render_file(
      '/etc/repose/keystone-v2.cfg.xml'
    ).with_content(include('password="secretpass"'))
    expect(chef_run).to render_file(
      '/etc/repose/keystone-v2.cfg.xml'
    ).with_content(include('uri="secreturi"'))
  end
end
