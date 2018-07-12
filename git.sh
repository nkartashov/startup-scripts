function gpl {
  git pull "$@"
}
function gps {
  git push "$@"
}
function gpsu {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  git push --set-upstream origin "$BRANCH" "$@"
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
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  git checkout master &&
  git branch -D "$BRANCH" &&
  git checkout "$BRANCH"
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
function gbr {
  git branch "$@"
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

alias uncommit_last='git reset HEAD~1 --soft'

function git_to_ssh {
  local CURRENT_URL=$(git remote -v | head -1 | cut -f2 | cut -d' ' -f1)
  local HTTP_PREFIX='https://github.com/'
  local SSH_PREFIX='git@github.com:'
  local REPO=${CURRENT_URL#$HTTP_PREFIX}
  local FULL_GIT_URL="$SSH_PREFIX$REPO"
  echo $CURRENT_URL '->' $FULL_GIT_URL
  git remote set-url origin $FULL_GIT_URL
}
