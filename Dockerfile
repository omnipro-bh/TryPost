FROM ghcr.io/trypostit/trypost:latest

# Use composer config to safely add the dont-discover entry
RUN composer config --no-interaction --json --merge extra.laravel.dont-discover '["laravel/pail"]'

# Regenerate the autoloader and let Composer's post-autoload-dump scripts run
# so Laravel's cached package manifest (bootstrap/cache/packages.php) is
# rebuilt to honor the dont-discover entry above. Using --no-scripts here
# would leave the stale manifest in place, still referencing
# Laravel\Pail\PailServiceProvider even though the package isn't installed.
RUN composer dump-autoload

# Explicitly regenerate Laravel's package discovery manifest to ensure the
# dont-discover exclusion takes effect immediately.
RUN php artisan package:discover --ansi || true
