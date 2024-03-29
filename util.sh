function include {
  if [ -f "$1" ] ; then
    source "$1" && echo "Sourced $1"
  else
    echo "$1 doesn't exist"
  fi
}

function command_exists {
  type "$1" &> /dev/null ;
}

function get_first_item_in_list_command {
  head -2 | tail -1 | cut -f1 -d' '
}

function get_shell {
  ps -o comm= "$$"
}

function is_bash {
  local shell=$(get_shell)
  [[ "$shell" =~ "bash" ]]
}

function is_zsh {
  local shell=$(get_shell)
  [[ "$shell" =~ "zsh" ]]
}