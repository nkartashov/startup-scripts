#!/bin/bash
function includeDirInPath {
  if [ -d "$1" ] ; then
    PATH="$1:$PATH"
  fi
}
export CUDA_HOME=/usr/local/cuda
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$CUDA_HOME/lib"

includeDirInPath "$CUDA_HOME/bin"
includeDirInPath "/Library/Haskell/bin"
includeDirInPath "$HOME/bin"
includeDirInPath "/usr/local/Homebrew/bin"
includeDirInPath "/usr/local/bin"
includeDirInPath "/Users/nikita_kartashov/.local/bin"
includeDirInPath "/Users/nikita_kartashov/anaconda3/bin"
