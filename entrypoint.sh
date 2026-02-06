#!/bin/bash
set -e

# Print the port
echo "Render PORT is: $PORT"

# Default DB values if not set
: "${ODOO_DB_NAME:=odoo_db}"
: "${ODOO_DB_USER:=odoo_user}"
: "${ODOO_DB_PASSWORD:=odoo_pass}"
: "${ODOO_DB_HOST:=db}"
: "${ODOO_DB_PORT:=5432}"

# Export PGPASSWORD for psql commands
export PGPASSWORD="$ODOO_DB_PASSWORD"

# Check if the database exists
DB_EXISTS=$(psql -h "$ODOO_DB_HOST" -U "$ODOO_DB_USER" -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$ODOO_DB_NAME';")

if [ "$DB_EXISTS" != "1" ]; then
    echo "Database $ODOO_DB_NAME does not exist. Creating..."
    createdb -h "$ODOO_DB_HOST" -U "$ODOO_DB_USER" "$ODOO_DB_NAME"
    echo "Database created."
fi

echo "Initializing Odoo database (base module)..."

# Run Odoo
exec odoo \
  --config=/etc/odoo/odoo.conf \
  -i base \
  --without-demo=True \
  --http-port="$PORT" \
  --http-interface=0.0.0.0
