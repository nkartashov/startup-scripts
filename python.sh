alias py="pypy"
alias py3="python3"
function ppy() {
  pipenv run python3 "$@"
}
function pitr() {
  pip install -r test_requirements.txt "$@"
}
function cw() {
  cd "$@"
  w $(basename "$@")
}
function w() {
  # Activates the virtualenv which is particular to this directory, either the
  # pipenv one or the one named like this dir
  local CURRENT_DIR=$(pwd | xargs basename)
  if [ ! -f "$CURRENT_DIR"/Pipfile ] && command_exists pipenv; then
    pipenv shell
  elif command_exists workon; then
    workon "$CURRENT_DIR"
  else
    echo 'Neither pipenv nor virtualenvwrapper are installed'
  fi
}
function auh() {
  # Shorthand for upgrading to the newest revision
  PYTHONPATH=. alembic upgrade head
}

# IPython launch
alias ipn='ipython notebook --profile solarized'
alias jp='jupyter notebook'
