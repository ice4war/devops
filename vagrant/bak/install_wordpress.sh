sudo dnf install -y httpd mariadb mariadb-server php php-mysqlnd wordpress

sudo setenforce 0
sudo sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

sudo mysql -u root -proot < /vagrant/wordpress_db.sql

cat << EOF |sudo tee /etc/wordpress/wp-config.php
<?php
define( 'DB_NAME', 'wordpress_db' );
define( 'DB_USER', 'wp_user' );
define( 'DB_PASSWORD', 'ADMIN@wordpress' );
define( 'DB_HOST', 'localhost' );
define( 'DB_CHARSET', 'utf8mb4' );
define( 'DB_COLLATE', '' );
$table_prefix = 'wp_';
define('DISALLOW_FILE_MODS', true);
define('FS_METHOD', 'direct');
define('AUTOMATIC_UPDATER_DISABLED', true);
define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
	define('ABSPATH', '/usr/share/wordpress');
}

require_once ABSPATH . 'wp-settings.php';
EOF
curl -s https://api.wordpress.org/secret-key/1.1/salt |sudo tee -a /etc/wordpress/wp-config.php

sudo sed -i 's/Require local/Require all granted/' /etc/httpd/conf.d/wordpress.conf
sudo mkdir /etc/httpd/auth.d
htpasswd -c /etc/httpd/auth.d/validusers rogue
htpasswd -b /etc/httpd/auth.d/validusers kitana nothing

cat << EOF | sudo tee -a /etc/httpd/conf.d/wordpress.conf
<Location /wordpress>
  AuthType Basic
  AuthName "Access for developers only"
  AuthUserFile auth.d/validusers
  Require valid-user
</Location>
EOF
sudo systemctl enable --now httpd mariadb