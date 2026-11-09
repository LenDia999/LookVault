<?php
session_start();
require_once 'configdatabase.php';
require_once __DIR__ . '/includes/media-storage.php';

if (!isset($_SESSION['usuario_id'])) {
    header('Location: login.php');
    exit;
}
$usuario_id = (int) $_SESSION['usuario_id'];
$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);

if ($id && $id > 0) {
    // A peça só pode ser removida pelo seu proprietário.
    $foto = executarQuery("SELECT foto FROM pecas WHERE id = ? AND usuario_id = ?", [$id, $usuario_id]);
    $result = executarQuery("DELETE FROM pecas WHERE id = ? AND usuario_id = ?", [$id, $usuario_id]);
    if ($result === true) {
        if ($foto && $foto->num_rows > 0) {
            lookvaultDeleteImage($foto->fetch_assoc()['foto'] ?? '');
        }
        header('Location: guarda-roupa.php?sucesso=' . urlencode('Peça excluída com sucesso!'));
        exit;
    }
}
header('Location: guarda-roupa.php?erro=' . urlencode('Não foi possível excluir a peça.'));
exit;
?>
