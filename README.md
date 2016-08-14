dotfiles
========

http://linuxg.net/how-to-install-vim-7-4-on-ubuntu-13-10-13-04-12-04-linux-mint-16-15-13-and-debian-sid/

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
### Install dotfiles using homemaker
If go is installed
```
cd dotfiles
GOPATH=$(pwd)/go go get github.com/FooSoft/homemaker
./go/bin/homemaker --verbose --task=bash --variant=mac config.toml .
```
or
```
cd dotfiles
curl -sLO https://foosoft.net/projects/homemaker/dl/homemaker_linux_amd64.tar.gz
tar xvf ./homemaker_linux_amd64.tar.gz
./homemaker_linux_amd64/homemaker --verbose --task=bash --variant=mac config.toml .

```

## Prebuilt docket image

FROM tdmanville/devbase

To build:
```
docker build -t tdmanville/devbase .
```
TODO:
 - Specify baseimage version rather than use latest.
 - Version devbase

