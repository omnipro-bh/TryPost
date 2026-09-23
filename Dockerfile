FROM ghcr.io/trypostit/trypost:latest

# 1. Set a dummy APP_KEY so Laravel's config files don't fail during the build
ENV APP_KEY=base64:dummy_key_for_build_only_do_not_use_in_production=

# 2. Prevent auto-discovery of missing dev packages
RUN composer config --no-interaction --json --merge extra.laravel.dont-discover '["laravel/pail"]'

# 3. Regenerate the autoloader. This will now succeed because APP_KEY is set.
RUN composer dump-autoload
RUN php artisan optimize:clear || true
