
```
source ~/.bash_extra

#install neovim with misc
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
sudo tar zxvf nvim-linux64.tar.gz -C /usr/local


sudo apt install git tig mc figlet ctags curl screen htop
sudo apt install python3-pip

#fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

#fzf-marks
git clone https://github.com/urbainvaes/fzf-marks.git

#install nodejs 14
wget https://nodejs.org/dist/v14.15.4/node-v14.15.4-linux-x64.tar.xz
sudo tar -xf node-v14.15.4-linux-x64.tar.xz -C /usr/local

sudo npm install -g neovim
sudo pip3 install pynvim neovim

#neovim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

:PlugInstall
:CocInstall coc-fzf-preview
:CocInstall coc-json
```
![dirMarks](https://github.com/lecheel/dot-files/blob/main/qtips.png)
