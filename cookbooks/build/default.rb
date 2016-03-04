execute "yum clean all" do
    user "root"
end

execute "yum update -y" do
    user "root"
end

package "epel-release"
package "gcc"
package "openssl-devel"
package "libyaml-devel"
package "readline-devel"
package "zlib-devel"
package "git"
