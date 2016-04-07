execute "yum -y remove mysql*"

package "http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm" do
    not_if 'rpm -q mysql-community-release-el6-5'
end
package "mysql-community-server"
package "mysql-community-devel"

service "mysqld" do
  action [:enable, :start]
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

