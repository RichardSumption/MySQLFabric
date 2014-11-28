# MySQL Fabric Role class
#
class fabric_controller {
   include fabric_data
   
   $groupid = 'fabric01'
   
   package {'mysql-utilities' :
      ensure => installed,
      require => [ Class['fabric_data'], Service["mysqld"] ],
   } ~>

   file { '/etc/mysql/fabric.cfg' :
      source => 'puppet:///modules/fabric_controller/fabric.cfg',
   } ~>

   file { '/etc/profile.d/alias.sh' :
      source => 'puppet:///modules/fabric_controller/alias.sh',
   } ~>

   mysql_user { 'fabric@localhost':
      ensure                   => 'present',
      max_connections_per_hour => '0',
      max_queries_per_hour     => '0',
      max_updates_per_hour     => '0',
      max_user_connections     => '0',
      password_hash            => '*CB4AFD4AA6D15B1B4B2F249F7386275638D906B8',
    } ~>

   mysql_grant { 'fabric@localhost/*.*' :
      ensure                   => present,
      options                  => GRANT,
      privileges               => ALL,
      table                    => '*.*',
      user                     => 'fabric@localhost',
   } ~>

   exec { 'initfabric' :
      unless => "/usr/bin/test -d /var/lib/mysql/fabric",
      command => '/usr/bin/mysqlfabric manage setup',
      require => [ Mysql_user['fabric@localhost'], Service["mysqld"] ],
   } ~>

   # Start mysqlfabric unless it's already running
   service { 'fabric':
     ensure => running,
     provider => base,
     start => '/usr/bin/mysqlfabric manage start --daemonize',
     stop => '/usr/bin/mysqlfabric manage stop',
     hasrestart => false,
     pattern => 'mysqlfabric',
     require => [ Mysql_user['fabric@localhost'], Service["mysqld"] ],
   }

/*   exec { 'startfabric' :
      unless => "/bin/ps -ef | grep -v grep | grep -q mysqlfabric",
      command => '/usr/bin/mysqlfabric manage start --daemonize',
      require => [ Mysql_user['fabric@localhost'], Service["mysqld"], Service['fabric'] ],
   } ~>
*/
   exec { 'fabricgroup' :
      unless => "/usr/bin/mysqlfabric group lookup_groups | grep -q $groupid",
      command => "/usr/bin/mysqlfabric group create $groupid",
      require => [ Mysql_user['fabric@localhost'], Service["mysqld"], Service['fabric'] ],
   } ~>

   exec { 'addnode1' :
         unless => "/usr/bin/mysqlfabric group lookup_servers $groupid | grep -q 172.16.0.11",
         command => "/usr/bin/mysqlfabric group add $groupid 172.16.0.11",
         require => [ Mysql_user['fabric@localhost'], Service["mysqld"], Service['fabric'] ],
   } ~>

   exec { 'addnode2' :
         unless => "/usr/bin/mysqlfabric group lookup_servers $groupid | grep -q 172.16.0.12",
         command => "/usr/bin/mysqlfabric group add $groupid 172.16.0.12",
         require => [ Mysql_user['fabric@localhost'], Service["mysqld"], Service['fabric'] ],
   } ~>

   exec { 'addnode3' :
         unless => "/usr/bin/mysqlfabric group lookup_servers $groupid | grep -q 172.16.0.13",
         command => "/usr/bin/mysqlfabric group add $groupid 172.16.0.13",
         require => [ Mysql_user['fabric@localhost'], Service["mysqld"], Service['fabric'] ],
   } ~>

   exec { 'promote' :
         unless => "/usr/bin/mysqlfabric group lookup_servers $groupid | grep -q PRIMARY",
         command => "/usr/bin/mysqlfabric group promote $groupid",
         require => [ Mysql_user['fabric@localhost'], Service["mysqld"], Service['fabric'] ],
   } ~>

   exec { 'activate' :
         command => "/usr/bin/mysqlfabric group activate $groupid",
   }
}
