# Moving around
if [ -z "$WORK_PC" ]
then
  WORK_DIR="~/work"
  alias cdcpp="cd $WORK_DIR/cpp"
  alias cdunix="cd $WORK_DIR/unix"
  alias cdja="cd $WORK_DIR/java"
  alias cdw="cd $WORK_DIR"
  alias cdpy="cd $WORK_DIR/python"
  alias cdscm="cd $WORK_DIR/sicp"
  alias cdag="cd $WORK_DIR/agda"
  alias cdhs="cd $WORK_DIR/haskell"
  alias cdeu="cd $WORK_DIR/euler"
else
  :;
fi

# shortcuts
alias cdu="cd .."
alias g47="gcc-4.7"
alias py="pypy"
alias py3="python3"
alias v="vim"
alias c="clear"
alias cm="c; make"
alias vrc="v ~/.vimrc"
alias vpr="v ~/.bash_profile"
alias la="ls -lah"
alias ll="ls -lh"


# Vagrant
alias vu='vagrant up'
alias vs='vagrant ssh'
alias vh='vagrant halt'
alias vr='vagrant reload'
alias vd='vagrant destroy'
alias vrs='vr; vs'
alias vus='vu; vs'

# IPython launch
alias ipn='ipython notebook --profile solarized'
alias jp='jupyter notebook'

function gpl {
  git pull "$@"
}
function gps {
  git push "$@"
}
function ga {
  git add "$@"
}
function gs {
  git status "$@"
}
function gc {
	git commit "$@"
}
function gd {
  git diff "$@"
}
