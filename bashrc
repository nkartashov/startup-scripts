echo "Sourcing .bashrc"
START_SCRIPTS=~/startup-scripts
# But env goes even firster!
source "$START_SCRIPTS"/env.sh
# But env goes even firster!

# Path always goes first
source "$START_SCRIPTS"/path.sh
# Path always goes first

source "$START_SCRIPTS"/alias.sh
source "$START_SCRIPTS"/duco.sh
source "$START_SCRIPTS"/home.sh
source "$START_SCRIPTS"/git.sh
source "$START_SCRIPTS"/vars.sh
source "$START_SCRIPTS"/prompt.sh
source "$START_SCRIPTS"/title.sh
source "$START_SCRIPTS"/history.sh
source "$START_SCRIPTS"/completion.sh
