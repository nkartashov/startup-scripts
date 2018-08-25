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
  workon $(basename "$@")
}
function w() {
  local CURRENT_DIR=$(pwd | xargs basename)
  if [ ! -f "$CURRENT_DIR"/Pipfile ]; then
    pipenv shell
  else
    workon "$CURRENT_DIR"
  fi
}

# IPython launch
alias ipn='ipython notebook --profile solarized'
alias jp='jupyter notebook'
