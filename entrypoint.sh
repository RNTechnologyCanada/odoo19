#!/bin/bash
set -e

echo "Render PORT is: ${PORT}"
echo "DB: ${ODOO_DB_NAME} @ ${ODOO_DB_HOST}:${ODOO_DB_PORT}"

# 1) Initialize DB if not initialized yet
# (This is safe to run each deploy: if already initialized, it won't break.)
odoo \
  --config=/etc/odoo/odoo.conf \
  -d "${ODOO_DB_NAME}" \
  -i base \
  --without-demo=all \
  --stop-after-init \
  --db_host="${ODOO_DB_HOST}" \
  --db_port="${ODOO_DB_PORT}" \
  --db_user="${ODOO_DB_USER}" \
  --db_password="${ODOO_DB_PASSWORD}"

echo "Starting Odoo..."
# 2) Start server
exec odoo \
  --config=/etc/odoo/odoo.conf \
  -d "${ODOO_DB_NAME}" \
  --http-port="${PORT}" \
  --db_host="${ODOO_DB_HOST}" \
  --db_port="${ODOO_DB_PORT}" \
  --db_user="${ODOO_DB_USER}" \
  --db_password="${ODOO_DB_PASSWORD}"
