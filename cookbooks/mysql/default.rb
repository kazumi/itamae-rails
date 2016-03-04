execute "yum -y remove mysql*"

package "http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm" do
    not_if 'rpm -q mysql-community-release-el6-5'
end
package "mysql-community-server"
package "mysql-community-devel"

service "mysqld" do
  action :start
end
