package 'nginx'

template '/etc/nginx/nginx.conf'
template '/etc/sysconfig/nginx'

execute 'rm -f /etc/nginx/conf.d/default.conf'

directory '/var/lib/nginx' do
  mode '755'
  owner 'nginx'
  group 'nginx'
end

template '/etc/nginx/conf.d/vhosts.conf' do
  variables({hostname: run_command('hostname').stdout.strip})
  notifies :reload, 'service[nginx]'
end

service 'nginx' do
  action [:enable, :start]
end
