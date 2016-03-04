require 'spec_helper'

# describe package('httpd'), :if => os[:family] == 'redhat' do
#   it { should be_installed }
# end
#
# describe package('apache2'), :if => os[:family] == 'ubuntu' do
#   it { should be_installed }
# end
#
# describe service('httpd'), :if => os[:family] == 'redhat' do
#   it { should be_enabled }
#   it { should be_running }
# end
#
# describe service('apache2'), :if => os[:family] == 'ubuntu' do
#   it { should be_enabled }
#   it { should be_running }
# end
#
# describe service('org.apache.httpd'), :if => os[:family] == 'darwin' do
#   it { should be_enabled }
#   it { should be_running }
# end

describe port(80) do
  it { should be_listening }
end

describe command('source /etc/profile.d/rbenv.sh; which rbenv') do
  let(:disable_sudo) { true }
  its(:stdout) { should match %r{/usr/local/rbenv/bin/rbenv} }
end

describe file('/etc/profile.d/rbenv.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
  its(:content) { should match(/^export RBENV_ROOT="\/usr\/local\/rbenv"$/) }
  its(:content) { should match(/^export PATH="\${RBENV_ROOT}\/bin:\${PATH}"$/) }
  its(:content) { should match(/^eval "\$\(rbenv init --no-rehash -\)"$/) }
end

describe file('/usr/local/rbenv/plugins') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }
end

describe file('/usr/local/rbenv/plugins/ruby-build') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }
end

%w(2.3.0).each do |versoin|
  describe command("source /etc/profile.d/rbenv.sh; rbenv versions | grep #{versoin}") do
    let(:disable_sudo) { true }
    its(:stdout) { should match(/#{Regexp.escape(versoin)}/) }
  end
end

describe command('source /etc/profile.d/rbenv.sh; rbenv global') do
  let(:disable_sudo) { true }
  its(:stdout) { should match(/2.3.0/) }
end

