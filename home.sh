#!/bin/bash
if [ "$BASH_SCRIPTS_ENV" == "HOME" ]; then
  eval `docker-machine env 2>/dev/null`
fi
