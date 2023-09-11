#!/bin/sh
# Runs zsh with x86_64 architecture on M1

exec arch -x86_64 /bin/zsh "$@"