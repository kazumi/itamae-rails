execute "yum -y remove mysql*"

package "https://dev.mysql.com/get/mysql80-community-release-el6-1.noarch.rpm" do
    not_if 'rpm -q mysql80-community-release-el6-1.noarch'
end
remote_file "/etc/yum.repos.d/mysql-community.repo" do
    source "remote_files/mysql-community.repo"
    mode '644'
    owner 'root'
    group 'root'
end

package "mysql-community-server"
package "mysql-community-devel"

template "/etc/my.cnf" do
    source "remote_files/my.cnf.erb"
    variables({"validate_password" => ''})
    mode '644'
    owner 'root'
    group 'root'
end

service "mysqld" do
  action [:enable, :start]
end

template "/tmp/set_password.sh" do
    source "remote_files/set_password.sh.erb"
    variables({"root_password" => node[:secret]['mysql_root_password']})
    mode '755'
    owner 'root'
    group 'root'
end

execute 'set root password' do
  command '/tmp/set_password.sh'
  not_if "mysql -u root --defaults-file=/root/.my.cnf -e 'show databases;'"
end

template "/etc/my.cnf" do
    source "remote_files/my.cnf.erb"
    variables({"validate_password" => 'validate-password=OFF'})
    mode '644'
    owner 'root'
    group 'root'
end

service "mysqld" do
    action :restart
end

file "/tmp/set_password.sh" do
  action :delete
end

execute "mysql init" do
    command <<SQL
        mysqladmin -u root password #{node[:secret]['mysql_root_password']}
        mysql -u root -p#{node[:secret]['mysql_root_password']} -e "create database #{node[:mysql][:database_name]}"
        mysql -uroot -p#{node[:secret]['mysql_root_password']} -e "create user '#{node[:mysql][:user_name]}'@'localhost' identified by '#{node[:secret]['mysql_user_password']}'"
        mysql -u root -p#{node[:secret]['mysql_root_password']} -e "grant all privileges on #{node[:mysql][:database_name]}.* to '#{node[:mysql][:user_name]}'@'localhost';"
        mysql -u root -p#{node[:secret]['mysql_root_password']} -e "FLUSH PRIVILEGES;"
SQL
end

