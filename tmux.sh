#! /bin/sh
#
# font.sh
# Copyright (C) 2015 manville <manville@manville-vm>
#
# Distributed under terms of the MIT license.
#


wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
sudo apt-get install fontconfig
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo fc-cache -vf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

