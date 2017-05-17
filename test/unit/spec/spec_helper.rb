require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'
ChefSpec::Coverage.start! do
  add_output do |report|
    begin
      erb = Erubis::Eruby.new(File.read('coverage_template.erb'))
      File.open('index.html', 'w') do |f|
        f.puts(erb.evaluate(report))
      end
    rescue NameError => e
      raise Error::ErbTemplateParseError.new(original_error: e.message)
    end
  end
end

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
