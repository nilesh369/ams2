#!/bin/bash
# Execute to setup

COMPOSER_CMD=$(which composer)
NPM_CMD=$(which npm)
PHP_CMD=$(which php)

echo "Starting composer..."
$COMPOSER_CMD update
$COMPOSER_CMD dumpautoload -o
echo "Done composer..."

echo "Starting NPM installation..."
$NPM_CMD install
$NPM_CMD update
$NPM_CMD run production
echo "Done NPM..."

echo "Starting migration and seeding..."
$PHP_CMD artisan migrate:refresh --seed
$PHP_CMD artisan migrate
$PHP_CMD artisan db:seed
echo "Done migration and seeding..."

echo "Starting API and web server on localhost:8000..."
$PHP_CMD artisan serve
