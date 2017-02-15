# from http://techlife.cookpad.com/entry/2015/05/12/080000

require 'yaml'
secret = YAML.load_file("secret.yml")
node[:secret] = secret

["base","yum","ruby","mysql","nginx","redis","env","setting"].each{|name|
 include_recipe File.join("cookbooks", name, "default.rb")
}
