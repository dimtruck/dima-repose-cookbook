# encoding: utf-8
# copyright: 2015, Chef Software, Inc.
# license: All rights reserved

title '/tmp profile'

# you add controls here
control "repose-1.0" do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title "Create /etc/repose directory"             # A human-readable title
  desc "An optional description..."         # Describe why this is needed
  tag data: "config data"                     # A tag allows you to associate key information
  tag "security"                            # to the test
  ref "Document A-12", url: 'http://wiki.openrepose.org'    # Additional references

  describe file('/etc/repose') do                  # The actual test
    it { should be_directory }
  end
end

control "repose-valve-1.0" do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title "Create /usr/share/repose directory"             # A human-readable title
  desc "An optional description..."         # Describe why this is needed
  tag data: "config data"                     # A tag allows you to associate key information
  tag "security"                            # to the test
  ref "Document A-12", url: 'http://wiki.openrepose.org'    # Additional references

  describe file('/usr/share/repose') do                  # The actual test
    it { should be_directory }
  end

  describe command('which java') do                  # The actual test
    its('stdout') { should match /bin/ }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end

control "repose-config-owner" do
  impact 0.8
  title "repose config should have proper ownership"
  tag data: "config perms"
  tag "security"

  describe directory('/etc/repose/') do
    it { should exist }
    it { should be_directory }
    it { should be_readable }
    it { should be_writable }
    it { should be_executable.by_user('root') }
    it { should be_owned_by 'root' }
    its('mode') { should cmp '0644' }
  end
end
