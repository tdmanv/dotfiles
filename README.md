dotfiles
========


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
### Install stow

```
# Mac
homebrew install stow

#Linux
sudo apt-get install stow
```
### Install go

TODO: try https://github.com/sbonaiva/govm

https://go.dev/doc/install

```
curl https://go.dev/dl/go1.19.3.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
sudo ln -s /usr/local/go/bin/go /usr/local/bin

# Using snap (linux only)
sudo snap install go
```

#### Configure Shell: zsh
```
# Install oh my zsh
# run commands listed here: https://ohmyz.sh/#install

# Install oh my posh
# run commands listed here: https://ohmyposh.dev/docs/installation/macos#set-up-your-terminal

# Configuration for zsh is now managed by the general stow command in the "Configure Applications using Stow" section.
```

### Configure Applications using Stow
All application configurations are managed using `stow`. Most configurations can be installed by running the following command from the root of this repository:

```bash
stow --dir "${HOME}/dotfiles/stow" --target "${HOME}" -v */
```

Alternatively, you can install configurations for specific applications by replacing `*/` with the application name (e.g., `bash`, `git`, `nvim`, `tmux`, `zsh`).
The packages `bash-mac` and `tmux-mac` provide macOS specific configurations for Bash and Tmux respectively.

**Important Note for Neovim:** Neovim requires a specific target directory. Do NOT use the general command above for Neovim. See the "Vim/Neovim Setup" section below.

#### Vim/Neovim Setup

- **Neovim**:
    - Configuration files (e.g., `init.lua`) are located in `stow/nvim/`.
    - To correctly link these, use the following specific `stow` command:
      ```bash
      mkdir -p ${HOME}/.config/nvim
      stow --dir "${HOME}/dotfiles/stow" --target "${HOME}/.config/nvim" -S nvim
      ```
    - Installation:
        - macOS: `brew install neovim` (see also "install neovim mac" section)
        - Linux: `sudo apt-get install neovim` (or see "Install neovim" -> "Linux" section for AppImage instructions)
        - Python support: `python3 -m pip install --user --upgrade pynvim` (may require `sudo apt-get install python3-neovim` on some systems)

##### Recommended tools for Vim/Neovim development
For an enhanced development experience and to support certain plugins (like YouCompleteMe or language servers), consider installing the following tools:
- **General code navigation:**
  ```bash
  # For Debian/Ubuntu
  sudo apt-get install exuberant-ctags cscope
  # For macOS
  brew install ctags cscope
  ```
- **Build tools (often required by plugins for compilation):**
  ```bash
  # For Debian/Ubuntu
  sudo apt-get install cmake python3-dev build-essential
  # For macOS (cmake and build tools are usually part of Xcode Command Line Tools)
  brew install cmake # python3-dev is typically handled by Python installations e.g. via pyenv or brew
  ```
  After installing these, you might need to re-enter your Vim/Neovim and run plugin installation commands if a plugin (e.g., YouCompleteMe) requires compilation. For example, for YouCompleteMe: `cd ~/.vim/bundle/YouCompleteMe && python3 install.py --all` (adjust path as needed for your plugin manager).

#### Configure tmux
```
sudo apt-get install tmux

# Configuration for tmux is now managed by the general stow command in the "Configure Applications using Stow" section.
# Ensure you have run the stow command for tmux.

# Install tmux plugin manager
# https://github.com/tmux-plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install plugings using <prefix>+I when in a tmux session
```

##### Powerline Fonts
For Powerline symbols to display correctly in Tmux, you may need to install Powerline-patched fonts.
Instructions vary by operating system.

**For Debian/Ubuntu based systems:**
```bash
sudo apt-get install fontconfig
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo fc-cache -vf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
```
**For macOS:**
You can often find Powerline fonts through Homebrew, for example, by tapping a font cask like `homebrew/cask-fonts` and installing a "nerd font" or a specific Powerline font. Ensure your terminal application is configured to use the installed font.

**Other Systems:**
Search for instructions specific to your OS and font manager.

## install neovim mac
https://github.com/neovim/neovim/blob/master/INSTALL.md

```
# Install using brew
brew install neovim

# Configuration for neovim is now managed by the specific nvim stow command
# in the "Configure Applications using Stow" -> "Vim/Neovim Setup" section.

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

#### Glcoud
```
sudo apt-get install apt-transport-https ca-certificates gnupg
```

#### Tmux
https://github.com/erikw/tmux-powerline?tab=readme-ov-file
Install plugins in tmux <ctrl-a>I

## Misc
### codespaces
https://github.com/codespaces
```
gh codespace  create --devcontainer-path ".devcontainer/buildimage/devcontainer.json" --repo kastenhq/k10 --machine basicLinux32gb --branch devcontainer

```
# Deprecated

## Install neovim

## Linux
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
python3 -m pip install --user --upgrade pynvim
# Note: python3-neovim might be needed on some systems, e.g., sudo apt-get install python3-neovim
```

```
# log in/out to reset bash

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
