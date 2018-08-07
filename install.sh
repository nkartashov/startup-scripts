#!/bin/bash

RESULT_FOLDER=~/startup-scripts
set -e
if [[ ! -d $RESULT_FOLDER ]]; then
  git clone git@github.com:nkartashov/startup-scripts.git $RESULT_FOLDER
fi
ln -s $RESULT_FOLDER/bashrc ~/.bashrc
ln -s $RESULT_FOLDER/gitignore ~/.gitignore

SOLARIZED_DIR=~/solarized
if [[ ! -d $SOLARIZED_DIR ]]; then
  git clone git@github.com:altercation/solarized.git $SOLARIZED_DIR
fi


# TODO: add all the brew setup business
# TODO: add brew cask font tap
# TODO: add fira code
