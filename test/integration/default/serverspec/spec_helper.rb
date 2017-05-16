# frozen_string_literal: true

require 'serverspec'

# Set backend type
set :backend, :exec

RSpec.configure do |config|
  config.add_formatter 'json'
end
