sudo apt update && sudo apt install -y apache2 mariadb-server mariadb-client 
sudo apt install -y php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip

cd /tmp 
curl -O https://wordpress.org/latest.tar.gz
tar xf latest.tar.gz

sudo touch /tmp/wordpress/.htaccess
sudo mkdir /tmp/wordpress/wp-content/upgrade


cat <<EOF |sudo tee /etc/apache2/sites-available/wordpress.conf
<VirtualHost *:80>
    ServerAdmin webmaster@wordpress.local
    ServerName wordpress.local
    ServerAlias www.wordpress.local
    DocumentRoot /var/www/html/wordpress

    <Directory /var/www/html/wordpress/>
      AllowOverride All
    </Directory>

    ErrorLog /var/www/html/wordpress/logs/error.log
    CustomLog /var/www/html/wordpress/logs/access.log combined
</VirtualHost>
EOF
sudo mkdir -p /var/www/html/wordpress/{public,logs}
echo "<?php phpinfo(); ?>" > /var/www/html/wordpress/info.php

a2ensite wordpress
sudo a2enmod rewrite 
sudo systemctl restart apache2

sudo cp -a /tmp/wordpress/* /var/www/html/wordpress
cat <<EOF |sudo tee /var/www/html/wordpress/wp-config.php 
<?php
  define( 'DB_NAME', 'wordpress_db' );
  define( 'DB_USER', 'wp_user' );
  define( 'DB_PASSWORD', 'ADMIN@wordpress' );
  define( 'DB_HOST', 'localhost' );
  define( 'DB_CHARSET', 'utf8mb4' );
  define( 'DB_COLLATE', '' );
  $table_prefix = 'wp_';
  define( 'WP_DEBUG', false );
  if ( ! defined( 'ABSPATH' ) ) {
  	define( 'ABSPATH', __DIR__ . '/' );
  }
  require_once ABSPATH . 'wp-settings.php';
EOF
curl -s https://api.wordpress.org/secret-key/1.1/salt |sudo tee -a /var/www/html/wordpress/wp-config.php

sudo chown -R www-data:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod  750 {} \;
sudo find /var/www/html -type f -exec chmod 640 {} \;

mysql -u root -proot < /vagrant_data/wordpress_db.sql
    