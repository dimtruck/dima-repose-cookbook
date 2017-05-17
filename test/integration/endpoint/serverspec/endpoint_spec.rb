require_relative 'spec_helper'

describe file('/etc/service/gunicorn-service') do
  it { should be_symlink }
end

describe file('/etc/sv/gunicorn-service/log/run') do
  it { should be_file }
  it { should be_owned_by 'daemon' }
  it { should be_grouped_into 'daemon' }
  it { should be_mode 755 }
  its(:content) { should contain 'exec chpst -u daemon svlogd -tt ./main' }
end

describe file('/etc/sv/gunicorn-service/run') do
  it { should be_file }
  it { should be_owned_by 'daemon' }
  it { should be_grouped_into 'daemon' }
  it { should be_mode 755 }
  its(:content) { should contain(/exec chpst -u daemon gunicorn httpbin:app/) }
end

describe command('ps -ef | grep -v grep | grep "runsv gunicorn-service"') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/runsv gunicorn-service/) }
end
