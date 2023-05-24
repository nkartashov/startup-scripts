# Moving around
if [ -z "$WORK_PC" ]
then
  WORK_DIR="$HOME/work"
  alias cdcpp="cd $WORK_DIR/cpp"
  alias cdunix="cd $WORK_DIR/unix"
  alias cdja="cd $WORK_DIR/java"
  alias cdw="cd $WORK_DIR"
  alias cdscm="cd $WORK_DIR/sicp"
  alias cdag="cd $WORK_DIR/agda"
  alias cdhs="cd $WORK_DIR/haskell"
  alias cdeu="cd $WORK_DIR/euler"
else
  :;
fi

alias cdstart="cd ~/startup-scripts"
alias cdvim="cd ~/vim-scripts"

# shortcuts
alias c="clear"
alias cm="c; make"
alias la="ls -lah"
alias ll="ls -lh"

# Vim
function v {
  nvim -p "$@"
}
alias vrc="vim ~/.vimrc"
alias vpr="vim ~/.bash_profile"
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

# Short Ruby commands
function bx {
  bundler exec "$@"
}

function bxr {
  bundler exec rspec "$@"
}

function brake {
  bundler exec rake "$@"
}

# Key utils
function new_ssh_key {
  ssh-keygen -t rsa -b 4096 -C "$@"
}
function new_home_ssh_key {
  new_ssh_key snailandmail@gmail.com
}
function add_ssh_key {
  ssh-add -K "$@"
}
function ssh_fingeprint {
  ssh-keygen -lf "$@"
}

function gssh {
  gcloud compute ssh "$@"
}

function dus {
  du -sch .[!.]* * | gsort -rh
}

function fd {
  rake db:drop &&
  rake db:create &&
  rake db:migrate &&
  rake db:seed
}

function les {
  less -n -r "$@"
}

function jpp {
  json_pp --json_opt=canonical,pretty "$@"
}

function jtb {
  git checkout -b "$(tr '[:space:]' '-' "$@")"
}

function untilfail {
  while "$@"; do :; done
}

function update_brewfile {
  brew bundle dump --global --describe --force
}

function whats_my_ip {
  ipconfig getifaddr en0 
}

# TEMPORARY
alias cdold='cd /Volumes/Macintosh\ HD/Users/nikita_kartashov'

alias free_hdd='df -h | grep "Macintosh HD" | tr -s " " " " | cut -d" " -f4'

function forward_port {
  local HOST="$1"
  local PORT="$2"
  echo "Forwarding port ${PORT} to ${HOST}"
  ssh -o ServerAliveInterval=10 -L "${PORT}":127.0.0.1:"${PORT}" "${HOST}" 
}

function find_heavy_git_commits() {
  git rev-list --objects --all |
    git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
    sed -n 's/^blob //p' |
    sort --numeric-sort --key=2 |
    gcut -c 1-12,41- |
    $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}