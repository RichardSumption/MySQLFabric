# MySQL Fabric Role class
#
class fabric_data (
   $users,
   $grants,
   $databases        = {},
   $override_options,
   $root_password    = undef,
   ) {

   $opts = { mysqld => merge( $override_options[mysqld], { server-id => $serverid } ) }

   class { 'mysql::server' :
      users                   => $users,
      grants                  => $grants,
      databases               => $databases,
      root_password           => 'root123',
      override_options        => $opts,
      package_name            => 'mysql-community-server',
      remove_default_accounts => false,
   } ~>

   exec { 'stoplogbin' :
      command => "mysql -uroot -proot123 -e \"set global sql_log_bin=0\"",
      path    => "/usr/bin",
      require => Service["mysqld"],
   } ~>
   
   mysql_user {
    [ "root@${::fqdn}",
      'root@127.0.0.1',
      'root@::1',
      "@${::fqdn}",
      '@localhost',
      '@%']:
   ensure  => 'absent',
   } ~>

   exec { 'startlogbin' :
      command => "mysql -uroot -proot123 -e \"set global sql_log_bin=1\"",
      path    => "/usr/bin",
      require => Service["mysqld"],
   }

}
