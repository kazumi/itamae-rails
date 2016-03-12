## Usage

```
vagrant up
bundle exec itamae ssh -h 192.168.33.109 -u vagrant --node-json=node.json bootstrap.rb -i .vagrant/machines/default/virtualbox/private_key
bundle exec rake spec
```

### 初回のみ実行する

```
mysql_secure_installation
```


* itamae実行時、ERROR: Net::SSH::HostKeyMismatchが起きることがある。その場合~/.ssh/known_hosts に記述されている192.168.33.109を削除してからやり直す。
