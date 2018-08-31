# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# macOS brew completions
if type brew 2&>/dev/null; then
  for completion_file in $(brew --prefix)/etc/bash_completion.d/*; do
    include "$completion_file"
  done
fi

# Ubuntu completion
include /etc/bash_completion

# Better cd with z
include /usr/local/etc/profile.d/z.sh

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

include "$START_SCRIPTS"/git-completion.sh
