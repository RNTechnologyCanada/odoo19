FROM odoo:19.0

# Copy custom addons
COPY ./addons /mnt/extra-addons

# Copy configuration
COPY ./config/odoo.conf /etc/odoo/odoo.conf

# Copy entrypoint and set permissions at the same time
COPY --chmod=755 ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

