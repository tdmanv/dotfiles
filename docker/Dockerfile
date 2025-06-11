FROM ubuntu:16.04

WORKDIR /root

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y vim git wget exuberant-ctags cscope bash-completion cmake g++ python-dev python-pip silversearcher-ag stow

RUN git clone https://github.com/tdmanv/dotfiles.git && \
    cd dotfiles && \
    stow --dir /root/dotfiles/stow -S bash -t /root -v && \
    stow --dir /root/dotfiles/stow -S git -t /root -v && \
    stow --dir /root/dotfiles/stow -S inputrc -t /root -v && \
    mkdir -p /root/.config/nvim && \
    stow --dir /root/dotfiles/stow -S nvim -t /root/.config/nvim -v && \
    stow --dir /root/dotfiles/stow -S tmux -t /root -v && \
    stow --dir /root/dotfiles/stow -S zsh -t /root -v

# Clean up APT when done.
#RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
