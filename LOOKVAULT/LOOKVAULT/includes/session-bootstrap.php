<?php

if (getenv('SESSION_DRIVER') === 'database') {
    require_once __DIR__ . '/../configdatabase.php';
    require_once __DIR__ . '/database-session-handler.php';

    session_set_save_handler(new LookVaultDatabaseSessionHandler(), true);
    session_set_cookie_params([
        'secure' => getenv('VERCEL') === '1',
        'httponly' => true,
        'samesite' => 'Lax',
    ]);
}
