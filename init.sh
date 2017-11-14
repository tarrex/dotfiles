#!/bin/bash

set -eu
set -o pipefail

# git
if [ -f "~/.gitconfig" ];then
    mv ~/.gitconfig /tmp/.gitconfig
fi
if [ -f "~/.gitignore" ];then
    mv ~/.gitignore /tmp/.gitignore 
fi
if [ -f "~/.gitmessage" ];then
    mv ~/.gitmessage /tmp/.gitmessage 
fi
cp .gitconfig ~/.gitconfig
cp .gitignore ~/.gitignore 
cp .gitmessage ~/.gitmessage
echo "git has been initialized."

# tmux
if [ -f "~/.tmux.conf" ];then
    mv ~/.tmux.conf /tmp/.tmux.conf
fi
cp .tmux.conf ~/.tmux.conf 
echo "tmux has been initialized."

# pip
if [ -d "~/.pip" ];then
    mv ~/.pip/pip.conf /tmp/.pip.conf
fi 
cp .pip/pip.conf ~/.pip/pip.conf 
echo "pip has been initialized."

# htop
if [ -d "~/.config/htop" ];then
    mv ~/.config/htop/htoprc /tmp/htoprc 
fi
cp -r .config/htop/htoprc ~/.config/htop/htoprc 
echo "htop has been initialized."

# bash
if [ -f "~/.bashrc" ];then
    mv ~/.bashrc /tmp/.bashrc
fi 
cp .bashrc ~/.bashrc
source ~/.bashrc
echo "bash has been initialized."

# zsh
if [ -f "~/.zshrc" ];then
    mv ~/.zshrc /tmp/.zshrc
fi 
cp .zshrc ~/.zshrc
source ~/.zshrc
echo "zsh has been initialized."

# vim
if [ -d "~/.vim" ];then
    mv ~/.vim /tmp/.vim
fi
if [ -f "~/.vimrc" ]; then
    mv ~/.vimrc /tmp/.vimrc 
fi 
cp .vimrc ~/.vimrc
git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +q! +q!
echo "vim has been initialized."
