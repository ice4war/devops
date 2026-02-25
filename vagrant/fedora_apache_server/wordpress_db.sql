ALTER USER 'root'@'localhost' identified by 'Immortalsubzero@MK11';
FLUSH PRIVILEGES;
CREATE USER if not exists 'wp_user'@'%' IDENTIFIED BY 'ADMIN@wordpress';
CREATE database if not exists wordpress_db DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wp_user'@'%' IDENTIFIED BY 'ADMIN@wordpress';
FLUSH PRIVILEGES;
