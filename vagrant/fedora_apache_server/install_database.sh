echo -e "Nothing here!!"
sudo dnf install -y mariadb mariadb-server
sudo systemctl enable --now mariadb

source /vagrant/.env
cat <<EOF | sudo tee /tmp/script.sql  1>/dev/null
ALTER USER 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
CREATE USER if not exists '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';
CREATE database if not exists $MYSQL_DATABASE DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';
FLUSH PRIVILEGES;
EOF
sed s/#bind-address*/bind-address/g -i /etc/my.cnf.d/mariadb-server.cnf
mysql -u root -proot < /tmp/script.sql
sudo rm /tmp/script.sql
sudo systemctl restart mariadb
