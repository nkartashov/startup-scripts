# Completion for macOS
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

# Completion for Ubuntu
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
