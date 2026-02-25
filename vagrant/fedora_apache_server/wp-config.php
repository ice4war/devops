<?php
define("DB_NAME", "");
define("DB_USER", "");
define("DB_PASSWORD", "");
define("DB_HOST", "");
define("DB_CHARSET", "utf8mb4");
define("DB_COLLATE", "");

$table_prefix = "wp_";
define("WP_DEBUG", false);
if (!defined("ABSPATH")) {
    define("ABSPATH", __DIR__ . "/");
}

require_once ABSPATH . "wp-settings.php";
