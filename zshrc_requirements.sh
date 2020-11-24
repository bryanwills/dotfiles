#!/bin/bash
#clone the repo for powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# remove directory.
cd ..
rm -rf fonts
