#!/bin/bash

ln -s ./dotfiles/vimrc .vimrc  
ln -s ./dotfiles/tmux.conf .tmux.conf 
ln -s ./dotfiles/gitconfig .gitconfig 
cat ./dotfiles/bashrc >> .bashrc
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
sudo pip install git+git://github.com/Lokaltog/powerline

