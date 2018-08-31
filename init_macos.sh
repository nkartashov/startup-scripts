#!/bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap "homebrew/bundle"
brew bundle install --path=Brewfile

curl https://raw.githubusercontent.com/nkartashov/startup-scripts/master/install.sh | sh
curl https://raw.githubusercontent.com/nkartashov/vim-scripts/master/install.sh | sh
