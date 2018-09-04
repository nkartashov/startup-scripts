function dkillall {
  docker ps -q | xargs docker kill
}
