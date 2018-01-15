if [ "$BASH_SCRIPTS_ENV" == "DUCO" ]; then
  function local_rebuild_java() {
    mvn clean install -DskipTests &&
    rake workers:install
  }

  function rj() {
    local OLD_PWD="$PWD"
    cu &&
    cd src/java &&
    local_rebuild_java &&
    cd "$OLD_PWD"
  }
  alias db='mysql -uroot -ppassword --protocol=tcp local-production'
  alias tdb='mysql -uroot -ppassword --protocol=tcp cube_test'
  function f {
    rake apartment:drop &&
    rake apartment:create &&
    rake db:migrate &&
    rake db:seed &&
    rake db:trdb
  }

  function w() {
    cu &&
    rake ramdisk && echo 'Running MySQL on ramdisk'
    f &&
    rj
  }

  function cu() {
    cd ~/code/cube
  }

  function perc_paths() {
    cu &&
    find . -name database.yml -or -name reference.conf -or -name application.conf | xargs sed -i 's/host = localhost/host = "127.0.0.1"/; s/host: localhost/host: 127.0.0.1/'
  }

  function rebuild_exporter() {
    local OLD_PWD="$PWD"
    cu &&
    cd src/java &&
    cd config-processing &&
    local_rebuild_java &&
    cd ../full-tenant-export &&
    local_rebuild_java &&
    cd "$OLD_PWD"
  }
fi
