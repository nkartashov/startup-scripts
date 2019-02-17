# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
include /usr/local/etc/bash_completion
include /usr/local/etc/profile.d/z.sh
include /usr/local/opt/nvm/etc/bash_completion

if command_exists fasd; then
  eval "$(fasd --init auto)"
fi
