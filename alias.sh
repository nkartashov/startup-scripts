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
alias py="pypy"
alias py3="python3"
alias c="clear"
alias cm="c; make"
alias la="ls -lah"
alias ll="ls -lh"

# Vim
alias v="vim"
alias vrc="v ~/.vimrc"
alias vpr="v ~/.bash_profile"
function vn {
  vim -u NONE "$@"
}


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


# Short Ruby commands
function bx {
  bundler exec $@
}

function bxr {
  bundler exec rspec $@
}

# Key utils
alias new_ssh_key='ssh-keygen -t rsa -b 4096 -C snailandmail@gmail.com'
function add_ssh_key {
  ssh-add -K "$@"
}
function ssh_fingeprint {
  ssh-keygen -lf "$@"
}

function dus {
  du -sch .[!.]* * | gsort -rh
}

# TEMPORARY
alias cdold='cd /Volumes/Macintosh\ HD/Users/nikita_kartashov'
