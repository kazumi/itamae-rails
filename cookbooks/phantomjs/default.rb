%w(gcc gcc-c++ make flex bison gperf ruby
  openssl-devel freetype-devel fontconfig-devel
  libicu-devel sqlite-devel libpng-devel libjpeg-devel).each do |p|
  package p
end

tmp_dir = '/tmp'

execute "wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2" do
  cwd tmp_dir
end

execute 'bunzip2 phantomjs*.tar.bz2' do
  cwd tmp_dir
end

execute "tar xvf phantomjs*.tar" do
  cwd tmp_dir
end

execute "cp phantomjs*/bin/phantomjs /usr/local/bin/phantomjs" do
  cwd tmp_dir
end
