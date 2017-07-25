# encoding: utf-8

title 'Repose profile'

# you add controls here
control 'repose-1.0' do
  impact 0.7
  title 'Create /etc/repose directory'
  desc 'An optional description...'
  tag data: 'config data'
  tag 'security'
  ref 'Document A-12', url: 'http://wiki.openrepose.org'

  describe file('/etc/repose') do
    it { should be_directory }
  end
end

control 'repose-valve-1.0' do
  impact 0.7
  title 'Create /usr/share/repose directory'
  desc 'An optional description...'
  tag data: 'config data'
  tag 'security'
  ref 'Document A-12', url: 'http://wiki.openrepose.org'

  describe file('/usr/share/repose') do
    it { should be_directory }
  end

  describe command('which java') do
    its('stdout') { should match(/bin/) }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end

control 'repose-config-owner' do
  impact 0.8
  title 'repose config should have proper ownership'
  tag data: 'config perms'
  tag 'security'

  describe directory('/etc/repose/') do
    it { should exist }
    it { should be_directory }
    it { should be_readable }
    it { should be_writable }
    it { should be_executable.by_user('repose') }
    it { should be_owned_by 'repose' }
    its('mode') { should cmp '0755' }
  end
end
