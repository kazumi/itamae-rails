bashrc = "/home/#{node[:system_user_name]}/.bashrc"

execute "Add RAILS_ENV" do
  command "echo 'export RAILS_ENV=#{node[:rails_env]}' >> #{bashrc}"
  not_if "grep 'export RAILS_ENV=#{node[:rails_env]}' #{bashrc}"
end
