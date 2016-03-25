USER_NAME = node[:system_user_name]
HOME = "/home/#{USER_NAME}"

execute "wget git-completion.bash" do
    user USER_NAME
    command "wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash; mv ~/git-completion.bash ~/.git-completion.bash"
end

execute "wget git-prompt.sh" do
    user USER_NAME
    command "wget https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh ~/.git-prompt.sh; mv ~/git-prompt.sh ~/.git-prompt.sh"
end

BASHRC = "#{HOME}/.bashrc"

remote_file "#{HOME}/bashrc_setting" do
    source "remote_files/bashrc_setting"
end

execute "add prompt to .bashrc" do
    user USER_NAME
    command "cat ~/bashrc_setting >> #{BASHRC}; rm -f ~/bashrc_setting"
end

execute "install neobundle" do
    user USER_NAME
    command "mkdir -p #{HOME}/.vim/bundle; git clone https://github.com/Shougo/neobundle.vim #{HOME}/.vim/bundle/neobundle.vim"
end

remote_file "#{HOME}/.vimrc" do
    source "remote_files/setting/vim/.vimrc"
end

