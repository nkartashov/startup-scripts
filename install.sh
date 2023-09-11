#!/bin/sh

RESULT_FOLDER=~/startup-scripts
set -e
function command_exists {
  type "$1" &> /dev/null ;
}
function link_if_not_linked {
  if [ ! -L ~/."$1" ]; then
    ln -s "$RESULT_FOLDER/linked_files/$1" ~/".$1"
    echo "Linked $RESULT_FOLDER/linked_files/$1 -> ~/.$1"
  else
    echo "~/.$1 already exists"
  fi
}
if [[ ! -d "$RESULT_FOLDER" ]]; then
  git clone git@github.com:nkartashov/startup-scripts.git "$RESULT_FOLDER"
fi

link_if_not_linked bashrc
link_if_not_linked gitignore
link_if_not_linked iterm_shell_integration

SOLARIZED_DIR=~/solarized
if [[ ! -d "$SOLARIZED_DIR" ]]; then
  git clone https://github.com/altercation/solarized.git "$SOLARIZED_DIR"
fi

if ! command_exists brew; then
  echo "Brew not found, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
link_if_not_linked Brewfile

# Apply mac os settings changes.
./"$RESULT_FOLDER"/macos
