# frozen_string_literal: true

require 'serverspec'
require 'rspec_junit_formatter'

# Set backend type
set :backend, :exec

RSpec.configure do |config|
  config.add_formatter 'RspecJunitFormatter', '/opt/serverspec_endpoint.xml'
end
