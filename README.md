## Usage

* secret.ymlをsecret.yml.templateを元に作成。
* node.jsonをよしなに。

```
git submodule init
git submodule update
vagrant up
bundle exec itamae ssh -h 192.168.33.109 -u vagrant --node-json=node.json bootstrap.rb -i .vagrant/machines/default/virtualbox/private_key
```

* itamae実行時、ERROR: Net::SSH::HostKeyMismatchが起きることがある。その場合~/.ssh/known_hosts に記述されている192.168.33.109を削除してからやり直す。

