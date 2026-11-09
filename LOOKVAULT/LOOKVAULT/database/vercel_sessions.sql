CREATE TABLE IF NOT EXISTS `php_sessions` (
  `session_id` varchar(128) NOT NULL,
  `session_data` mediumblob NOT NULL,
  `last_activity` int unsigned NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `idx_php_sessions_last_activity` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
