FROM ghcr.io/trypostit/trypost:latest

# Accept the APP_KEY as a build argument from Railway
ARG APP_KEY
# Set it as an environment variable for the build process
ENV APP_KEY=$APP_KEY

# Prevent auto-discovery of missing dev packages
RUN composer config --no-interaction --json --merge extra.laravel.dont-discover '["laravel/pail"]'

# Regenerate the autoloader. This will now succeed because APP_KEY is set.
RUN composer dump-autoload

# Clear any stale caches
RUN php artisan optimize:clear || true
