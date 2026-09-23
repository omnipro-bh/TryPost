# Use the official TryPost image as the base
FROM ghcr.io/trypostit/trypost:latest

# Modify composer.json to prevent auto-discovery of the missing dev package
RUN php -r "
    \$file = '/var/www/html/composer.json';
    \$data = json_decode(file_get_contents(\$file), true);
    if (!isset(\$data['extra']['laravel']['dont-discover'])) {
        \$data['extra']['laravel']['dont-discover'] = [];
    }
    if (!in_array('laravel/pail', \$data['extra']['laravel']['dont-discover'])) {
        \$data['extra']['laravel']['dont-discover'][] = 'laravel/pail';
    }
    file_put_contents(\$file, json_encode(\$data, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
"

# Regenerate the autoloader and clear any stale caches
RUN composer dump-autoload
RUN php artisan optimize:clear || true
