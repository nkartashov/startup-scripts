#!/bin/sh
function includeDirInPath {
  if [ -d "$1" ] ; then
    PATH="$1:$PATH"
  fi
}

includeDirInPath "$HOME/bin"
includeDirInPath "$HOME/.local/bin"
includeDirInPath "/usr/local/Homebrew/bin"
includeDirInPath "/usr/local/bin"
includeDirInPath "/opt/homebrew/bin"
includeDirInPath "$HOME/.local/bin"
includeDirInPath "/usr/local/opt/icu4c/bin"
includeDirInPath "/usr/local/opt/icu4c/sbin"
includeDirInPath "/usr/local/opt/fzf/bin"
