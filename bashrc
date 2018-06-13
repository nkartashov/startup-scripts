echo "Sourcing .bashrc"
START_SCRIPTS=~/startup-scripts
function include {
  if [ -f "$1" ] ; then
    source "$1" && echo "Sourced $1"
  else
    echo "$1 doesn't exist"
  fi
}
# But env goes even firster!
include "$START_SCRIPTS"/env.sh
# But env goes even firster!

# Path always goes first
include "$START_SCRIPTS"/path.sh
# Path always goes first

include "$START_SCRIPTS"/alias.sh
include "$START_SCRIPTS"/duco.sh
include "$START_SCRIPTS"/home.sh
include "$START_SCRIPTS"/git.sh
include "$START_SCRIPTS"/vars.sh
include "$START_SCRIPTS"/prompt.sh
include "$START_SCRIPTS"/title.sh
include "$START_SCRIPTS"/history.sh
include "$START_SCRIPTS"/completion.sh
include "$START_SCRIPTS"/fzf.sh
