execute "yum clean all" do
    user "root"
end

execute "yum update -y" do
    user "root"
end

package "epel-release"
package "kernel"
package "kernel-devel"
package "kernel-headers"
package "gcc"
package "gcc-c++"
package "openssl-devel"
package "libyaml-devel"
package "readline-devel"
package "zlib-devel"
package "git"
package "vim"
package "wget"
package "sqlite-devel"
package "tcl"

