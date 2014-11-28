#
class mysql::server::install {

  package { 'mysql-community-server':
    ensure => $mysql::server::package_ensure,
    name   => $mysql::server::package_name,
  }

}
