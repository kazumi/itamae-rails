tmp_dir = '/tmp'
version = node[:redis][:source][:version]
installed_version = nil

string = run_command('redis-server --version 2>/dev/null', error: false).stdout.strip
if string.match(/v=(\d+\.\d+\.\d+)/)
  installed_version = $1
end

if installed_version != version
  execute "wget http://download.redis.io/releases/redis-#{version}.tar.gz" do
    cwd tmp_dir
  end
  
  execute "tar -zxvf redis-#{version}.tar.gz" do
    cwd tmp_dir
  end
  
  execute 'make test && make && make install' do
    cwd "#{tmp_dir}/redis-#{version}"
  end
end
