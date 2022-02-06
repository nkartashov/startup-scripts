#!/bin/sh
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -en "\033]0; $("dirs") \a"'
    ;;
*)
    ;;
esac
