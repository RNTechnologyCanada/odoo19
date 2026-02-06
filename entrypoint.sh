#!/bin/bash
set -e

echo "Render PORT is: $PORT"
echo "Initializing Odoo database (base module)..."

exec odoo \
  --config=/etc/odoo/odoo.conf \
  -i base \
  --without-demo=all \
  --http-port="$PORT"
