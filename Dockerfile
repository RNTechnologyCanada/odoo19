FROM odoo:19.0

# Copy custom addons
COPY ./addons /mnt/extra-addons

# Copy configuration
COPY ./config/odoo.conf /etc/odoo/odoo.conf

# Set entrypoint
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
