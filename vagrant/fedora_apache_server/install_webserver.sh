sudo dnf install -y httpd php \
    php-cli \
    php-fpm \
    php-common \
    php-mbstring \
    php-curl php-gd \
    php-mysqlnd php-json \
    php-xml php-intl php-pecl-apcu\
    php-opcache bsdtar;
source /vagrant/.env
sudo mkdir -p /var/www/{webserver,phpmyadmin,wordpress}
sudo cp /vagrant/conf.d/*.conf /etc/httpd/conf.d/
sudo cp /vagrant/httpd.conf /etc/httpd/conf/
sudo echo "<?php phpinfo(); ?>" > /var/www/webserver/info.php

curl --location https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip -O
sudo bsdtar --strip-components=1 -xvf phpMyAdmin-latest-all-languages.zip -C /var/www/phpmyadmin
curl -L -O https://wordpress.org/latest.zip
sudo bsdtar --strip-components=1 -xvf latest.zip -C /var/www/wordpress
sudo cp /vagrant/wp-config.php /var/www/wordpress
sudo curl https://api.wordpress.org/secret-key/1.1/salt >> /var/www/wordpress/wp-config.php

sudo cp /vagrant/config.inc.php /var/www/phpmyadmin/
sudo chown -R apache:apache /var/www
rm *.zip
sudo systemctl enable --now httpd

# dnf install php php-cli php-common php-fpm nginx -y
