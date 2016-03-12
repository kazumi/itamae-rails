if node[:redis][:source][:use] == "true"
  include_recipe 'source.rb'
else
  package 'redis'
end

directory '/usr/local/var/db/redis' do
  mode '755'
  owner 'root'
  group 'root'
end

directory '/etc/redis' do
  mode '755'
  owner 'root'
  group 'root'
end

template '/etc/redis/redis.conf'

template '/etc/init.d/redis' do
  mode '755'
  owner 'root'
  group 'root'
end

service 'redis' do
  action [:enable, :start]
end
