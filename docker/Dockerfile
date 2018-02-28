FROM ubuntu:16.04

WORKDIR /root

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y vim git wget exuberant-ctags cscope bash-completion cmake g++ python-dev python-pip silversearcher-ag

RUN git clone https://github.com/tdmanv/dotfiles.git && \
    cd dotfiles && \
    wget https://foosoft.net/projects/homemaker/dl/homemaker_linux_amd64.tar.gz && \
    tar xvf homemaker_linux_amd64.tar.gz && \
    ./homemaker_linux_amd64/homemaker --clobber --verbose config.toml . 

# Clean up APT when done.
#RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
