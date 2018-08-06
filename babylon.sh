
if [ "$BASH_SCRIPTS_ENV" == "BABYLON" ]; then
  export WORKON_HOME=~/envs
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
  export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='-p python3'
  source /usr/local/bin/virtualenvwrapper.sh

  export BABYLON_NAME="nikita.kartashov"
  export BABYLON_FULL_NAME="Nikita Kartashov"
fi
