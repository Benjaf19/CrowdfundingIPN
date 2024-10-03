GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.20.192' IDENTIFIED BY 'n0m3l0' WITH GRANT OPTION;
USE mysql;
SELECT user,host FROM user;
delete from user where host = '192.168.0.15';