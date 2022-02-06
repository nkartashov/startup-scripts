#!/bin/sh

ENV_FILE=~/.bash_scripts_env
if [ -e "$ENV_FILE" ]; then
  export BASH_SCRIPTS_ENV=$(cat "$ENV_FILE")
else
  export BASH_SCRIPTS_ENV="HOME"
fi
ENV_VARIABLE_FILE=~/.env_variables
function export_env() {
  export $(cat "$@" | xargs)
}
if [ -e "$ENV_VARIABLE_FILE" ]; then
  export_env "$ENV_VARIABLE_FILE"
fi
export EDITOR="vim"

export NVM_DIR="$HOME/.nvm"
include /usr/local/opt/nvm/nvm.sh

export PYENV_ROOT=~/.pyenv
export WORKON_HOME=~/envs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='-p python3'
source /usr/local/bin/virtualenvwrapper.sh
