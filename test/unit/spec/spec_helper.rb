require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'

::LOG_LEVEL = :fatal
::UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '14.04'
}.freeze

def stub_resources
  allow(Chef::EncryptedDataBagItem).to receive(:load).with(
    'passwords', 'repose'
  ).and_return(
    'user' => 'secretdima',
    'pass' => 'secretpass',
    'uri' => 'secreturi'
  )
end

at_exit { ChefSpec::Coverage.report! }
