echo "Sourcing .bashrc"
START_SCRIPTS=~/startup-scripts
# Path always goes first
source "$START_SCRIPTS"/path.sh
# Path always goes first

source "$START_SCRIPTS"/alias.sh
source "$START_SCRIPTS"/vars.sh
source "$START_SCRIPTS"/prompt.sh
source "$START_SCRIPTS"/title.sh
source "$START_SCRIPTS"/history.sh
source "$START_SCRIPTS"/completion.sh
