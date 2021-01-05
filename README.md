
```
source ~/.bash_extra

#install neovim with misc

#sudo apt install git tig mc figlet ctags curl screen htop
#sudo apt install python3-pip

#fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

#fzf-marks
git clone https://github.com/urbainvaes/fzf-marks.git

#install nodejs 15
sudo curl -sL https://deb.nodesource.com/setup_15.x | bash -
su -c 'apt update'
su -c 'apt install -y nodejs'


sudo npm install -g neovim
sudo pip3 install pynvim neovim

#neovim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

:PlugInstall
:CocInstall coc-fzf-preview
:CocInstall coc-json
```
