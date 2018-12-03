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
