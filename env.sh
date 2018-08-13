#!/bin/bash

ENV_FILE=~/.bash_scripts_env
if [ -e "$ENV_FILE" ]; then
  export BASH_SCRIPTS_ENV=$(cat "$ENV_FILE")
else
  export BASH_SCRIPTS_ENV="HOME"
fi
ENV_VARIABLE_FILE=~/.env_variables
if [ -e "$ENV_VARIABLE_FILE" ]; then
  export $(cat "$ENV_VARIABLE_FILE" | xargs)
fi
export EDITOR="vim"
