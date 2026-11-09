<?php

function lookvaultIsVercelBlobUrl($value)
{
    $host = parse_url((string) $value, PHP_URL_HOST);
    return is_string($host) && str_ends_with($host, '.blob.vercel-storage.com');
}

function lookvaultImageAvailable($value)
{
    if (!is_string($value) || $value === '') {
        return false;
    }

    if (lookvaultIsVercelBlobUrl($value)) {
        return true;
    }

    if (filter_var($value, FILTER_VALIDATE_URL)) {
        return parse_url($value, PHP_URL_SCHEME) === 'https';
    }

    if (str_starts_with($value, 'uploads/') && !str_contains($value, '..')) {
        return is_file(dirname(__DIR__) . '/' . $value);
    }

    return false;
}

function lookvaultBlobRequest($method, $url, $headers, $body)
{
    $context = stream_context_create([
        'http' => [
            'method' => $method,
            'header' => implode("\r\n", $headers),
            'content' => $body,
            'ignore_errors' => true,
            'timeout' => 20,
        ],
    ]);

    error_clear_last();
    $responseBody = @file_get_contents($url, false, $context);
    $status = 0;
    foreach ($http_response_header ?? [] as $responseHeader) {
        if (preg_match('/^HTTP\/\S+\s+(\d{3})/', $responseHeader, $matches)) {
            $status = (int) $matches[1];
        }
    }

    if ($responseBody === false || $status < 200 || $status >= 300) {
        $error = error_get_last();
        error_log('LOOKVAULT Vercel Blob request failed (HTTP ' . $status . '): ' . ($error['message'] ?? 'request rejected'));
        throw new RuntimeException('Não foi possível acessar o armazenamento de imagens.');
    }

    return $responseBody;
}

function lookvaultSaveImage($temporaryPath, $folder, $extension, $mimeType)
{
    $pathname = trim($folder, '/') . '/' . bin2hex(random_bytes(16)) . '.' . $extension;
    $token = getenv('BLOB_READ_WRITE_TOKEN');

    if (getenv('VERCEL') === '1' || $token) {
        if (!$token) {
            throw new RuntimeException('Configure BLOB_READ_WRITE_TOKEN no ambiente do Vercel para enviar imagens.');
        }

        $content = file_get_contents($temporaryPath);
        if ($content === false) {
            throw new RuntimeException('Não foi possível ler a imagem enviada.');
        }

        $url = 'https://vercel.com/api/blob/?' . http_build_query(
            ['pathname' => $pathname],
            '',
            '&',
            PHP_QUERY_RFC3986
        );
        $response = lookvaultBlobRequest('PUT', $url, [
            'Authorization: Bearer ' . $token,
            'x-api-version: 13',
            'x-vercel-blob-access: public',
            'x-add-random-suffix: true',
            'x-content-type: ' . $mimeType,
            'Content-Type: ' . $mimeType,
        ], $content);
        $blob = json_decode($response, true);

        if (!is_array($blob) || !is_string($blob['url'] ?? null) || !lookvaultIsVercelBlobUrl($blob['url'])) {
            error_log('LOOKVAULT Vercel Blob returned an invalid upload response.');
            throw new RuntimeException('O armazenamento retornou uma resposta inválida ao enviar a imagem.');
        }

        return $blob['url'];
    }

    $relativePath = $pathname;
    $destination = dirname(__DIR__) . '/' . $relativePath;
    $directory = dirname($destination);

    if (!is_dir($directory) && !mkdir($directory, 0755, true) && !is_dir($directory)) {
        throw new RuntimeException('Não foi possível preparar o diretório para a imagem.');
    }

    if (!move_uploaded_file($temporaryPath, $destination)) {
        throw new RuntimeException('Não foi possível salvar a imagem enviada.');
    }

    return $relativePath;
}

function lookvaultDeleteImage($value)
{
    if (!is_string($value) || $value === '') {
        return true;
    }

    if (lookvaultIsVercelBlobUrl($value)) {
        $token = getenv('BLOB_READ_WRITE_TOKEN');
        if (!$token) {
            error_log('LOOKVAULT could not delete a Vercel Blob: BLOB_READ_WRITE_TOKEN is not configured.');
            return false;
        }

        try {
            lookvaultBlobRequest('POST', 'https://vercel.com/api/blob/delete', [
                'Authorization: Bearer ' . $token,
                'x-api-version: 13',
                'Content-Type: application/json',
            ], json_encode(['urls' => [$value]], JSON_THROW_ON_ERROR));
            return true;
        } catch (RuntimeException $exception) {
            error_log('LOOKVAULT image cleanup failed: ' . $exception->getMessage());
            return false;
        }
    }

    if (str_starts_with($value, 'uploads/') && !str_contains($value, '..')) {
        $path = dirname(__DIR__) . '/' . $value;
        return !is_file($path) || unlink($path);
    }

    return false;
}
