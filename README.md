dotfiles
========

http://linuxg.net/how-to-install-vim-7-4-on-ubuntu-13-10-13-04-12-04-linux-mint-16-15-13-and-debian-sid/

## codespaces
https://github.com/codespaces
```
gh codespace  create --devcontainer-path ".devcontainer/buildimage/devcontainer.json" --repo kastenhq/k10 --machine basicLinux32gb --branch devcontainer
```

## Installtion
### Get repo
```
cd
git clone git@github.com:tdmanv/dotfiles.git
```
```
cd
curl -sLO https://github.com/tdmanv/dotfiles/archive/master.tar.gz
tar xvf master.tar.gz
mv dotfiles-master
```
### Install go
https://go.dev/doc/install
```
curl https://go.dev/dl/go1.19.3.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
sudo ln -s /usr/local/go/bin/go /usr/local/bin

# Using snap
sudo snap install go
```

### Install config files using Stow
```
# Mac
homebrew install stow
#Linux
sudo apt-get install stow
```

#### Configure Shell: zsh
```

# Install oh my zsh
# run commands listed here: https://ohmyz.sh/#install

# Install oh my posh
# run commands listed here: https://ohmyposh.dev/docs/installation/macos#set-up-your-terminal

# Create configuration files
stow --dir "${HOME}/dotfiles/stow" --target "${HOME}" -v 5 zsh
```
#### Configure Shell: tmux
```
sudo apt-get install tmux


# Copy the tmux config
stow --dir "${HOME}/dotfiles/stow" --target "${HOME}" -v 5 tmux

# Install tmux plugin manager
# https://github.com/tmux-plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install plugings using <prefix>+I
```

### Install files using homemaker (deprecating)

#### Linux
```
cd dotfiles
go install foosoft.net/projects/homemaker@latest
~/go/bin/homemaker --verbose --task=bash --variant=linux config.toml .

# log in/out to reset bash

# Install neovim

## Linux

```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
python3 -m pip install --user --upgrade pynvim
sudo apt-get install python3-neovim

# Deprecated using homemaker
~/go/bin/homemaker --verbose --task=nvim_config --variant=linux config.toml .
```

## install neovim mac
https://github.com/neovim/neovim/blob/master/INSTALL.md
```
# Install Using Brew
brew install neovim

# Link config using stow
mkdir -p "${HOME}/.config/nvim"
stow --dir "${HOME}/dotfiles/stow" --target "${HOME}/.config/nvim/" -v 5 nvim

# Add extensions
brew install ripgrep

```



# Install node
# https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
nvm install --lts
# Update npm
npm install -g npm@10.1.0

# Install bash language server
npm i -g bash-language-server
```

#### Python
```
```

#### Tmux
https://github.com/erikw/tmux-powerline?tab=readme-ov-file
Install plugins in tmux <ctrl-a>I
```
~/go/bin/homemaker --verbose --task=tmux config.toml .

```

#### Tmux (deprecated)
```
# log in/out to reset bash
~/go/bin/homemaker --verbose --task=vim --variant=linux config.toml .

# YCM requires some dependencies to be built
# https://github.com/ycm-core/YouCompleteMe
sudo apt-get update
sudo apt install vim-nox cmake python3-dev build-essential
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --all

# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

 echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli
# https://www.digitalocean.com/community/questions/how-to-fix-docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket

```
#### Glcoud
```
sudo apt-get install apt-transport-https ca-certificates gnupg
```

