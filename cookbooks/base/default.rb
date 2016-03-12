GROUP_NAME = node[:system_user_name]
USER_NAME = node[:system_user_name]

group GROUP_NAME do
  groupname GROUP_NAME
  gid 600
end

user USER_NAME do
  action :create
  username USER_NAME
  gid GROUP_NAME
  create_home true
  password USER_NAME.crypt('at.me')
end

directory "/data" do
  mode '755'
  owner USER_NAME
  group GROUP_NAME
end

directory "/data/#{USER_NAME}/log" do
  mode '755'
  owner USER_NAME
  group GROUP_NAME
end

execute "chown -R #{USER_NAME}:#{GROUP_NAME} /data"

file "/etc/sudoers.d/#{USER_NAME}" do
  mode '440'
  owner 'root'
  group 'root'
  content "#{USER_NAME} ALL=(ALL) NOPASSWD:ALL"
end
