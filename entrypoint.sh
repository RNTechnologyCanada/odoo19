#!/bin/bash
set -e

echo "Starting Odoo 19 Community..."

exec odoo \
  --db_host=$DB_HOST \
  --db_port=$DB_PORT \
  --db_user=$DB_USER \
  --db_password=$DB_PASSWORD
