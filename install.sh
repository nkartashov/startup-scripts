#!/bin/bash

RESULT_FOLDER=~/startup-scripts
git clone https://github.com/nkartashov/startup-scripts.git $RESULT_FOLDER &&
ln -s $RESULT_FOLDER/bashrc ~/.bashrc
