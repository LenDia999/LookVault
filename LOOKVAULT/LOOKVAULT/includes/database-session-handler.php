<?php

final class LookVaultDatabaseSessionHandler implements SessionHandlerInterface
{
    private $connection;

    public function open(string $path, string $name): bool
    {
        $this->connection = conectarDB();
        return true;
    }

    public function close(): bool
    {
        if ($this->connection instanceof mysqli) {
            $this->connection->close();
            $this->connection = null;
        }

        return true;
    }

    public function read(string $id): string|false
    {
        $statement = $this->connection->prepare(
            'SELECT session_data FROM php_sessions WHERE session_id = ? AND last_activity >= ?'
        );
        $activeAfter = time() - (int) ini_get('session.gc_maxlifetime');
        $statement->bind_param('si', $id, $activeAfter);
        $statement->execute();
        $result = $statement->get_result();
        $row = $result->fetch_assoc();
        $statement->close();

        return $row['session_data'] ?? '';
    }

    public function write(string $id, string $data): bool
    {
        $statement = $this->connection->prepare(
            'INSERT INTO php_sessions (session_id, session_data, last_activity)
             VALUES (?, ?, ?)
             ON DUPLICATE KEY UPDATE session_data = VALUES(session_data), last_activity = VALUES(last_activity)'
        );
        $lastActivity = time();
        $statement->bind_param('ssi', $id, $data, $lastActivity);
        $saved = $statement->execute();
        $statement->close();

        return $saved;
    }

    public function destroy(string $id): bool
    {
        $statement = $this->connection->prepare('DELETE FROM php_sessions WHERE session_id = ?');
        $statement->bind_param('s', $id);
        $deleted = $statement->execute();
        $statement->close();

        return $deleted;
    }

    public function gc(int $max_lifetime): int|false
    {
        $statement = $this->connection->prepare('DELETE FROM php_sessions WHERE last_activity < ?');
        $expiredBefore = time() - $max_lifetime;
        $statement->bind_param('i', $expiredBefore);
        $deleted = $statement->execute() ? $statement->affected_rows : false;
        $statement->close();

        return $deleted;
    }
}
