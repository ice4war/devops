alter user 'root'@'localhost' identified by 'Immortalsubzero@MK11';
FLUSH PRIVILEGES;
create user if not exists 'wp_user'@'localhost' IDENTIFIED BY 'ADMIN@wordpress';
create database if not exists wordpress_db DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wp_user'@'localhost' IDENTIFIED BY 'ADMIN@wordpress';
FLUSH PRIVILEGES;