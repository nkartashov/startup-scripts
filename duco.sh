if [ "$BASH_SCRIPTS_ENV" == "DUCO" ]; then
  alias rj='mvn clean install -DskipTests && rake workers:install'
  alias db='mysql --user=root --password=password --database=tenant1'
  alias tdb='mysql --user=root --password=password --database=cube_test'
  function f {
    rake apartment:drop &&
    rake apartment:create &&
    rake db:migrate &&
    rake db:seed &&
    rake db:trdb
  }
  function w() {
    cu && f
  }
  function atlas_bxr() {
    TEST_EN=mt-atlas bxr "$@"
  }
  function cu() {
    cd ~/code/cube
  }
  function perc() {
    cu &&
    find . -name database.yml -or -name reference.conf -or -name application.conf | xargs sed -i 's/host = localhost/host = "127.0.0.1"/; s/host: localhost/host: 127.0.0.1/'
  }
fi
