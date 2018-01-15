if [ "$BASH_SCRIPTS_ENV" == "DUCO" ]; then
  function rj() {
    local OLD_PWD="$PWD"
    cu &&
    cd src/java &&
    mvn clean install -DskipTests &&
    rake workers:install &&
    cd "$OLD_PWD"
  }
  alias db='mysql -uroot -ppassword --protocol=tcp tenant1'
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
    rake ramdisk &&
    f
  }

  function cu() {
    cd ~/code/cube
  }

  function perc_paths() {
    cu &&
    find . -name database.yml -or -name reference.conf -or -name application.conf | xargs sed -i 's/host = localhost/host = "127.0.0.1"/; s/host: localhost/host: 127.0.0.1/'
  }

  function rebuild_exporter() {
    cu &&
    cd src/java &&
    cd config-processing &&
    rj &&
    cd ../full-tenant-export &&
    rj &&
    cd ..
  }
fi
