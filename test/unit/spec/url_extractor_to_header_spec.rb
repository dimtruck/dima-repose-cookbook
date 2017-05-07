require 'chefspec'
require_relative 'spec_helper'

describe 'dima-repose::default' do
  before { stub_resources }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(UBUNTU_OPTS).converge(described_recipe)
  end

  it 'creates a template /etc/repose/url-extractor-to-header.cfg.xml' do
    expect(chef_run).to create_template(
      '/etc/repose/url-extractor-to-header.cfg.xml'
    )
  end

  it 'populates /etc/repose/url-extractor-to-header.cfg.xml with attrs' do
    expect(chef_run).to render_file(
      '/etc/repose/url-extractor-to-header.cfg.xml'
    ).with_content(
      include(
        'header="User" url-regex="/users/(.*)/devices" default="standard"'
      )
    )
  end
end
