#!/bin/bash

brew cask install xquartz
brew install haskell-stack openvpn gcc coreutils cmake fdupes ag
brew install vim --with-client-server --with-lua --with-luajit --with-tcl --with-python3
ESSENTIALS="xquartz alfred day-o google-drive keepassxc anaconda iterm2 the-unarchiver java virtualbox"
MESSENGERS="skype telegram whatsapp slack"
MISC="tunnelbear electrum mplayerx tunnelblick beardedspice google-chrome openoffice steam torbrowser"
brew cask install "$ESSENTIALS $MESSENGERS $MISC"
curl https://raw.githubusercontent.com/nkartashov/startup-scripts/master/install.sh | sh
curl https://raw.githubusercontent.com/nkartashov/vim-scripts/master/install.sh | sh
