#!/bin/sh
setopt PROMPT_SUBST

precmd() {
  git_branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  if [[ -n "$git_branch" ]]; then

	if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      uncommitted_changes="*"
    else
      uncommitted_changes=""
    fi

    # Check for unpushed commits
    if [[ -n $(git log @{u}.. 2>/dev/null) ]]; then
      unpushed_commits=">"
    else
      unpushed_commits=""
    fi

    git_info="%F{cyan}$git_branch%f%F{magenta}$uncommitted_changes$unpushed_commits %f"
  else
    git_info=""
  fi
}

PROMPT='${git_info}%~$ '
