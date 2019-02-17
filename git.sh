function gpl {
  git pull "$@"
}
function gps {
  git push "$@"
}
function get_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
function gpsu {
  BRANCH=$(get_branch)
  git push --set-upstream origin "$BRANCH" "$@"
}
function gpr {
  # Push changes and create a pr
  if ! command_exists hub; then
    echo "Cannot find hub! Install hub or add it to PATH"
    return 1
  fi
  gpsu &&
  hub pull-request
}
function ga {
  git add "$@"
}
function gs {
  git status "$@"
}
function g {
  gs "$@"
}
function gc {
	git commit "$@"
}
function gd {
  git diff "$@"
}
function gdc {
  git diff --cached "$@"
}
function gch {
  git checkout "$@"
}
function fetch_rebased {
  BRANCH=$(get_branch)
  git checkout master &&
  git branch -D "$BRANCH" &&
  git checkout "$BRANCH"
}
function checkout_master_and_run_command {
  BRANCH=$(get_branch)
  git checkout master &&
  git pull &&
  git checkout "$BRANCH" &&
  git "$1" master
}
function gmm {
  checkout_master_and_run_command merge
}
function gf {
  git fetch "$@"
}
function gl {
  git log "$@"
}
function gsh {
  git show "$@"
}
function gst {
  git stash -u
}
function gsta {
  git stash apply "$@"
}
function gbl {
  git blame "$@"
}
function gcp {
  git cherry-pick "$@"
}
function grb {
  git rebase "$@"
}
function grbm {
  checkout_master_and_run_command rebase
}
function gbr {
  git branch "$@"
}
function gbm {
  git checkout master &&
  git pull &&
  git checkout -b "$@"
}
function gchm {
  git checkout master "$@"
}
function gmr {
  git merge "$@"
}
function grs {
  git reset "$@"
}
function grss {
  git reset --soft "$@"
}

function ghist {
  git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short "$@"
}

function list_conflicted {
  git diff --name-only --diff-filter=U
}

# Delete old branches which are already merged and keep master/develop/staging
alias gbpurge='git branch --merged | grep -Ev "(\*|master|develop|staging)" | xargs -n 1 git branch -d'

alias wip='git commit -m "wip"'

function git_to_ssh {
  local CURRENT_URL=$(git remote -v | head -1 | cut -f2 | cut -d' ' -f1)
  local HTTP_PREFIX='https://github.com/'
  local SSH_PREFIX='git@github.com:'
  local REPO=${CURRENT_URL#$HTTP_PREFIX}
  local FULL_GIT_URL="$SSH_PREFIX$REPO"
  echo "$CURRENT_URL -> $FULL_GIT_URL"
  git remote set-url origin "$FULL_GIT_URL"
}

function gca {
  git commit --amend "$@"
}

function gcan {
  git commit --amend --no-edit "$@"
}
function refetch_submodule {
  git submodule sync
  git submodule update --init
}

function get_unmerged {
  git diff --name-only --diff-filter=U
}

function edit_unmerged {
  vim -p "$(get_unmerged)"
}
function add_unmerged {
  git add "$(get_unmerged)"
}
function get_added_files {
  git diff --cached --name-only "$@"
}
function gaa {
  # git add added
  get_added_files | xargs git add
}
