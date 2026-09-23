FROM ghcr.io/trypostit/trypost:latest

# Use composer config to safely add the dont-discover entry
RUN composer config --no-interaction --json --merge extra.laravel.dont-discover '["laravel/pail"]'

# Regenerate the autoloader and clear any stale caches
RUN composer dump-autoload --no-scripts
RUN php artisan optimize:clear || true
