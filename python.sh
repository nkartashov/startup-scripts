#!/bin/sh
alias pt="pytest"
alias py="pypy"
alias py3="python3"
function ppy() {
  pipenv run python3 "$@"
}
function pitr() {
  pip install -r test_requirements.txt "$@"
}
function cw() {
  cd "$@" || return
  w "$(basename "$@")"
}
function w() {
  # Activates the virtualenv which is particular to this directory, either the
  # pipenv one or the one named like this dir
  local CURRENT_DIR=$(pwd)
  while true; do
    if [ -f "$CURRENT_DIR"/Pipfile ]; then
      # We need to use pipenv
      if command_exists pipenv; then
        pipenv shell
      else
        echo 'Pipenv is not installed'
      fi
      break
    elif [ -f "$CURRENT_DIR"/requirements.txt ]; then
      # We need to use venv
      if command_exists workon; then
        workon "$(basename "$CURRENT_DIR")"
      else
        echo 'Virtualenvwrapper is not installed'
      fi
      break
    else
      if [ "$CURRENT_DIR" != "/" ]; then
        # Go up a dir
        CURRENT_DIR=$(dirname "$CURRENT_DIR")
      else
        echo 'Cannot find either requirements.txt or Pipfile'
        break
      fi
    fi
  done
}
function mkvenv() {
  local CURRENT_DIR=$(pwd | xargs basename)
  mkvirtualenv "$CURRENT_DIR"
}
function a() {
  PYTHONPATH=. alembic "$@"
}
function auh() {
  # Shorthand for upgrading to the newest revision
  PYTHONPATH=. alembic upgrade head
}

# IPython launch
alias ipn='ipython notebook --profile solarized'
alias jp='jupyter notebook'
