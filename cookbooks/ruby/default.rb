USER_NAME = node[:system_user_name]

RBENV_DIR = "/home/#{USER_NAME}/.rbenv"
RBENV_SCRIPT = "/etc/profile.d/rbenv.sh"

git RBENV_DIR do
    repository "git://github.com/sstephenson/rbenv.git"
    user USER_NAME
end

git "#{RBENV_DIR}/plugins/ruby-build" do
    repository "git://github.com/sstephenson/ruby-build.git"
    user USER_NAME
end

remote_file RBENV_SCRIPT do
    source "remote_files/rbenv.sh"
    mode '644'
    owner 'root'
    group 'root'
end

execute "mkdir #{RBENV_DIR}/plugins" do
    not_if "test -d #{RBENV_DIR}/plugins"
end

node["rbenv"]["versions"].each do |version|
    execute "install ruby #{version}" do
        command "source #{RBENV_SCRIPT}; rbenv install #{version}"
        not_if "source #{RBENV_SCRIPT}; rbenv versions | grep #{version}"
        user USER_NAME
    end
end

execute "set global ruby #{node["rbenv"]["global"]}" do
    command "source #{RBENV_SCRIPT}; rbenv global #{node["rbenv"]["global"]}; rbenv rehash"
    not_if "source #{RBENV_SCRIPT}; rbenv global | grep #{node["rbenv"]["global"]}"
    user USER_NAME
end

node["rbenv"]["gems"].each do |gem|
    execute "gem install #{gem}" do
        command "source #{RBENV_SCRIPT}; gem install #{gem}; rbenv rehash"
        not_if "source #{RBENV_SCRIPT}; gem list | grep #{gem}"
        user USER_NAME
  end
end

