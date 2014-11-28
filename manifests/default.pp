node 'data01' {

   $serverid = '1'

   host { 
      'fabric': ip => '172.16.0.10';
      'data02': ip => '172.16.0.12';
      'data03': ip => '172.16.0.13';
   }

   include fabric_data
}

node 'data02' {

   $serverid = '2'

   host {
      'fabric': ip => '172.16.0.10';
      'data01': ip => '172.16.0.11';
      'data03': ip => '172.16.0.13';
   }

   include fabric_data
}

node 'data03' {

   $serverid = '3'

   host {
      'fabric': ip => '172.16.0.10';
      'data01': ip => '172.16.0.11';
      'data02': ip => '172.16.0.12';
   }

   include fabric_data
}

node 'fabric' {

   $serverid = '4'

   host {
      'data01': ip => '172.16.0.11';
      'data02': ip => '172.16.0.12';
      'data03': ip => '172.16.0.13';
   }

   include fabric_controller
}
