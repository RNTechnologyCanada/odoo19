#!/bin/bash
set -e

echo "Render PORT is: $PORT"
echo "Starting Odoo..."

exec odoo \
  --config=/etc/odoo/odoo.conf \
  --db_host="$ODOO_DB_HOST" \
  --db_port="$ODOO_DB_PORT" \
  --db_user="$ODOO_DB_USER" \
  --db_password="$ODOO_DB_PASSWORD" \
  --db_name="$ODOO_DB_NAME" \
  --xmlrpc_port="$PORT"
