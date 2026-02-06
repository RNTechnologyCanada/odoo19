#!/bin/bash
set -e

echo "Render PORT is: ${PORT}"
echo "DB: ${ODOO_DB_NAME} @ ${ODOO_DB_HOST}:${ODOO_DB_PORT}"

# Check if DB is initialized (table exists)
export PGPASSWORD="${ODOO_DB_PASSWORD}"

if psql \
  -h "${ODOO_DB_HOST}" \
  -p "${ODOO_DB_PORT}" \
  -U "${ODOO_DB_USER}" \
  -d "${ODOO_DB_NAME}" \
  -tAc "SELECT 1 FROM information_schema.tables WHERE table_name='ir_module_module' LIMIT 1;" \
  | grep -q 1; then
  echo "✅ Database already initialized. Skipping base install."
else
  echo "🆕 Database not initialized. Installing base module..."
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
fi

echo "🚀 Starting Odoo..."
exec odoo \
  --config=/etc/odoo/odoo.conf \
  -d "${ODOO_DB_NAME}" \
  --http-port="${PORT}" \
  --db_host="${ODOO_DB_HOST}" \
  --db_port="${ODOO_DB_PORT}" \
  --db_user="${ODOO_DB_USER}" \
  --db_password="${ODOO_DB_PASSWORD}"
