#!/bin/sh

cat > /var/www/html/bacula-web/application/config/config.php <<EOF
<?php
// Show inactive clients (false by default)
\$config['show_inactive_clients'] = true;

// Hide empty pools (displayed by default)
\$config['hide_empty_pools'] = false;

// Jobs per page (Jobs report page)
\$config['jobs_per_page'] = 25;

// Translations
\$config['language'] = 'en_US';

//MySQL bacula catalog
\$config[0]['label'] = 'Backup Server';
\$config[0]['host'] = '$MYSQL_HOST';
\$config[0]['login'] = '$MYSQL_USER';
\$config[0]['password'] = '$MYSQL_PASSWORD';
\$config[0]['db_name'] = '$MYSQL_DATABASE';
\$config[0]['db_type'] = 'mysql';
\$config[0]['db_port'] = '$MYSQL_PORT';
?>
EOF

cat > /etc/httpd/conf.d/bacula-web.conf <<EOF
<Directory /var/www/html/bacula-web>
  AllowOverride All
</Directory>
EOF

echo "date.timezone = $PHP_TIMEZONE" >> /etc/php.ini

chcon -R -t httpd_sys_rw_content_t /var/www/html/bacula-web/application/view/cache

chown -Rv apache:apache /var/www/html/bacula-web

/usr/sbin/httpd -D FOREGROUND
