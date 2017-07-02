describe file('/etc/sysconfig/repose') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0644' }
end

describe file('/etc/repose/system-model.cfg.xml') do
  it { should be_file }
  it { should be_owned_by 'repose' }
  it { should be_grouped_into 'repose' }
  its('mode') { should cmp '0644' }
end

describe file('/etc/repose/container.cfg.xml') do
  it { should be_file }
  it { should be_owned_by 'repose' }
  it { should be_grouped_into 'repose' }
  its('mode') { should cmp '0644' }
end

describe file('/etc/repose/header-normalization.cfg.xml') do
  it { should be_file }
  it { should be_owned_by 'repose' }
  it { should be_grouped_into 'repose' }
  its('mode') { should cmp '0644' }
  its(:content) { should match(/header id="Auth-Token"/) }
end

describe service('repose-valve') do
  it { should be_enabled }
end
