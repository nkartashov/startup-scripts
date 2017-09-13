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
alias w='cd ~/code/cube && rake ramdisk && f'
alias atlas_bxr='TEST_EN=mt-atlas bxr'
alias cu='cd ~/code/cube'
