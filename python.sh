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
  local CURRENT_DIR=$(pwd | xargs basename)
  if [ ! -f "$CURRENT_DIR"/Pipfile ] && command_exists pipenv; then
    pipenv shell
  elif command_exists workon; then
    workon "$CURRENT_DIR"
  else
    echo 'Neither pipenv nor virtualenvwrapper are installed'
  fi
}

# IPython launch
alias ipn='ipython notebook --profile solarized'
alias jp='jupyter notebook'
