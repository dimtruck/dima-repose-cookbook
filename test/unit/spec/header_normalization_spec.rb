require 'chefspec'
require_relative 'spec_helper'

describe 'dima-repose::default' do
  before { stub_resources }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(UBUNTU_OPTS).converge(described_recipe)
  end

  it 'creates a template /etc/repose/header-normalization.cfg.xml' do
    expect(chef_run).to create_template(
      '/etc/repose/header-normalization.cfg.xml'
    )
  end

  it 'populates /etc/repose/header-normalization.cfg.xml with default attrs' do
    expect(chef_run).to render_file(
      '/etc/repose/header-normalization.cfg.xml'
    ).with_content(include('<whitelist id="headers">'))
    expect(chef_run).to render_file(
      '/etc/repose/header-normalization.cfg.xml'
    ).with_content(include('<header id="Auth-Token"/>'))
    expect(chef_run).to render_file(
      '/etc/repose/header-normalization.cfg.xml'
    ).with_content(include('<header id="Host"/>'))
  end
end
