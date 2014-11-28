node 'data01' {

   $serverid = '1'
   $control  = 'fabric': ip => '172.16.0.10'
   $data1    = 'data01': ip => '172.16.0.11'
   $data2    = 'data02': ip => '172.16.0.12'
   $data3    = 'data03': ip => '172.16.0.13'
   
#   $ips {
#     fabric => '172.16.0.10',
#     data01 => '172.16.0.11',
#     data02 => '172.16.0.12',
#     data03 => '172.16.0.13',
#   }
   
   host {
#      $ips.each |name, ip| {
#         name: ip => $ip
#   }
      [ $control, $data2, $data3 ]
   }

   include fabric_data
}

node 'data02' {

   $serverid = '2'

   host {
      $control;
      $data1;
      $data3;
   }

   include fabric_data
}

node 'data03' {

   $serverid = '3'

   host {
      $control;
      $data1;
      $data2;
   }

   include fabric_data
}

node 'fabric' {

   $serverid = '4'

   host {
      $data1;
      $data2;
      $data3;
   }

   include fabric_controller
}
