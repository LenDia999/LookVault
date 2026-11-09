FROM dunglas/frankenphp:php8.4-bookworm

WORKDIR /app

RUN docker-php-ext-install mysqli \
    && mkdir -p /tmp/php-sessions \
    && chmod 1777 /tmp/php-sessions \
    && printf "session.save_path=/tmp/php-sessions\nauto_prepend_file=/app/includes/session-bootstrap.php\n" > /usr/local/etc/php/conf.d/sessions.ini

COPY . /app/
COPY Caddyfile /etc/caddy/Caddyfile

ENV PORT=80
ENV SESSION_DRIVER=database

CMD ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]
