set sql_log_bin=0;
drop user 'root'@'127.0.0.1';
drop user 'root'@'::1';
delete from mysql.user where user = 'root' and host = @@hostname;
delete from mysql.user where user = '';
set sql_log_bin=1;
