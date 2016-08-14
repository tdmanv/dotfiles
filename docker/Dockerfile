# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage

RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y vim git exuberant-ctags cscope bash-completion cmake g++ python-dev python-pip silversearcher-ag

# Install dotfiles
## Clone from github 
RUN cd ~/ && \
    git clone https://github.com/tdmanv/dotfiles.git && \
    cd dotfiles && \
    curl -O https://foosoft.net/projects/homemaker/dl/homemaker_linux_amd64.tar.gz && \
    tar xvf homemaker_linux_amd64.tar.gz && \
    ./homemaker_linux_amd64/homemaker --clobber --verbose config.toml . 

# Clean up APT when done.
#RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
