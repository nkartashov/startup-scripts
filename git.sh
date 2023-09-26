GITHUB_USER=nkartashov

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
function gstp {
  git stash push -u -- "$@"
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
function reset_author {
  git commit --amend --reset-author --no-edit "$@"
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
function setup_personal_git {
  git config --global core.editor "vim"
  git config --global user.name "Nick Kartashov"
  git config --global user.email "snailandmail@gmail.com"
}

function rac {
  local COMMAND="GIT_EDITOR=true $(git status | grep -o 'git \b.*\b --continue')"
  git status | grep 'both modified:' | awk '{print $NF}' | xargs git add
  eval $COMMAND
}

convert_seconds() {
    local total_seconds=$1
    local output=""

    local years=$((total_seconds / 31536000))
    if (( years > 0 )); then
        output="${output}${years}y"
    fi

    local remainder=$((total_seconds % 31536000))
    local months=$((remainder / 2592000))
    if (( months > 0 )); then
        output="${output}${months}M"
    fi

    remainder=$((remainder % 2592000))
    local days=$((remainder / 86400))
    if (( days > 0 )); then
        output="${output}${days}d"
    fi

    remainder=$((remainder % 86400))
    local hours=$((remainder / 3600))
    if (( hours > 0 )); then
        output="${output}${hours}h"
    fi

    remainder=$((remainder % 3600))
    local minutes=$((remainder / 60))
    if (( minutes > 0 )); then
        output="${output}${minutes}m"
    fi

    local seconds=$((remainder % 60))
    if (( seconds > 0 )); then
        output="${output}${seconds}s"
    fi

    echo "$output"
}

function delete_merged_branches() {
  : '
  - `<(...)` is process substitution that allows the output of a command to be treated as a file.
  - `gh pr list --author nkartashov --state closed | cut -f3 | sort` gets the list of branches from your closed PRs, extracts the branch names, and sorts them.
  - `git branch --merged | tr -d " *" | sort` lists the local branches, removes the leading spaces and asterisk (which indicates the current branch), and sorts the output.
  - `comm -12` compares the two sorted lists and outputs only the lines that appear in both (i.e., the branches that exist both locally and in the list of closed PRs).
  - `xargs -n 1 -p git branch -d` prompts you for confirmation and attempts to delete each branch if confirmed.
  '
  comm -12 <(gh pr list --author "$GITHUB_USER" --state closed | cut -f3 | sort) <(git branch --merged | tr -d ' *' | sort) | xargs -n 1 -p git branch -d
}
