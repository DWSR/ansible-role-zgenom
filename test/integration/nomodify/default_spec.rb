user = 'kitchen'
user_dir = "/home/#{user}"

# http://inspec.io/docs/reference/resources/file/
describe file("#{user_dir}/.zshrc") do
  it { should exist }
  it { should_not be_more_permissive_than('0744') }
  its('owner') { should eq user }
  its('group') { should eq user }
  its('content') { should_not match %r{brew} }
  its('content') { should_not match %r{# BEGIN ZGENOM BLOCK}}
  its('content') { should_not match %r{if ! zgen saved} }
  its('content') { should_not match %r{zgen save$}}
  its('content') { should_not match %r{# END ZGENOM BLOCK}}
end

# http://inspec.io/docs/reference/resources/directory/
describe directory("#{user_dir}/.zgen/.git") do
  it { should exist }
  its('owner') { should eq user }
  its('group') { should eq user }
end

%w[zgen.zsh zgenom.zsh].each do |f|
  # http://inspec.io/docs/reference/resources/file/
  describe file("#{user_dir}/.zgen/#{f}") do
    it { should exist }
    its('owner') { should eq user }
    its('group') { should eq user }
  end
end

# http://inspec.io/docs/reference/resources/file/
describe file("#{user_dir}/.zgen/init.zsh") do
  it { should_not exist }
end
