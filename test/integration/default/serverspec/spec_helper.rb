# frozen_string_literal: true

require 'serverspec'
require 'rspec_junit_formatter'

# Set backend type
set :backend, :exec

RSpec.configure do |config|
  config.add_formatter 'RspecJunitFormatter', '/opt/test/serverspec_default.xml'
  config.after(:all) do
    `useradd -r -s /bin/false jenkins`
    `chown jenkins:jenkins /opt/test/serverspec_default.xml`
  end
end
