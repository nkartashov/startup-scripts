#!/bin/bash

RESULT_FOLDER=~/startup-scripts
set -e
if [[ ! -d $RESULT_FOLDER ]]; then
  git clone git@github.com:nkartashov/startup-scripts.git $RESULT_FOLDER
fi
ln -s $RESULT_FOLDER/bashrc ~/.bashrc
