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

  FIRST_COMMIT_MESSAGE=$(git log master.."$BRANCH" --format="%s%n%n%b" | head -n 1)
  FIRST_COMMIT_BODY=$(git log master.."$BRANCH" --format="%s%n%n%b" | tail -n +2)

  PR_URL=$(gh pr create --base master --head "$BRANCH" --title "$FIRST_COMMIT_MESSAGE" --body "$FIRST_COMMIT_BODY")
  open "$PR_URL"
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
    # Get the list of branches from closed PRs
  closed_pr_branches=$(gh pr list --author "$GITHUB_USER" --state closed | cut -f3 | sort)

  # Get the list of local branches
  local_branches=$(git branch | tr -d ' *' | sort)

  # Find the common branches between the two lists
  common_branches=$(comm -12 <(echo "$closed_pr_branches") <(echo "$local_branches"))


  # Process each common branch
  echo "$common_branches" | while read -r branch; do
      # Attempt to delete the branch, passing "yes" to any prompts
      output=$(yes | git branch -d "$branch" 2>&1)
      # Filter only the deletion confirmation messages
      echo "$output" | grep 'Deleted branch'
  done
}

function restore_to_master() {
  git checkout origin/master "$@"
}
