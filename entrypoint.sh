#!/bin/bash
set -e

# Use env vars for DB connection
odoo -c /etc/odoo/odoo.conf --db_host=$POSTGRES_HOST --db_port=$POSTGRES_PORT \
--db_user=$POSTGRES_USER --db_password=$POSTGRES_PASSWORD --workers=0
