<?php
define( 'DB_NAME', 'database_name_here' );
define( 'DB_USER', 'username_here' );
define( 'DB_PASSWORD', 'password_here' );
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
