#!/bin/bash
function includeDirInPath {
  if [ -d "$1" ] ; then
    PATH="$1:$PATH"
  fi
}

if [ -z "$WORK_PC" ]
then
  export CUDA_HOME=/usr/local/cuda
  export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$CUDA_HOME/lib"

  includeDirInPath "$CUDA_HOME/bin"
  includeDirInPath "/Library/Haskell/bin"
  includeDirInPath "$HOME/bin"
  includeDirInPath "/usr/local/Homebrew/bin"
  includeDirInPath "/usr/local/bin"
  includeDirInPath "$HOME/.local/bin"
  includeDirInPath "$HOME/anaconda3/bin"
else
  :;
fi
