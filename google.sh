#!/bin/bash

WORKSTATION_HOST=nkartashov.lon.corp.google.com
function forward_workstation_port {
  local PORT="$1"
  forward_port "${WORKSTATION_HOST}" "${PORT}"
}

function connect_cloud_sql_proxy {
  PORT=3307 cloud_sql_proxy -instances=waking-dev:europe-west2:dev-environments=tcp:"$PORT"
}
