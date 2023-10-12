export DOCKER_DEFAULT_PLATFORM=linux/amd64

function lookup_docker_id {
  echo "$(docker ps | tail +2 | head -"$1" | tail -1 | cut -f1 -d' ')"
}
function dkillall {
  docker ps -q | xargs docker kill
}
function dps {
  docker ps | nl -v 0
}
function d {
  shift
  echo docker "$@" "$CONTAINER_ID"
  docker "$@" "$CONTAINER_ID"
}
function dexec {
  CONTAINER_ID=$(lookup_docker_id "$1")
  shift
  echo docker exec -it "$CONTAINER_ID" "$@"
  docker exec -it "$CONTAINER_ID" "$@"
}
