#!/bin/sh

# Additional Config
sed -i '' -e 's?listen = 127.0.0.1:9000?listen = /var/run/php-fpm.sock?g' /usr/local/etc/php-fpm.d/www.conf
sed -i '' -e 's/;listen.owner = www/listen.owner = www/g' /usr/local/etc/php-fpm.d/www.conf
sed -i '' -e 's/;listen.group = www/listen.group = www/g' /usr/local/etc/php-fpm.d/www.conf
sed -i '' -e 's/;listen.mode = 0660/listen.mode = 0600/g' /usr/local/etc/php-fpm.d/www.conf
cp /usr/local/etc/php.ini-production /usr/local/etc/php.ini
sed -i '' -e 's?;date.timezone =?date.timezone = "Universal"?g' /usr/local/etc/php.ini
sed -i '' -e 's?;cgi.fix_pathinfo=1?cgi.fix_pathinfo=0?g' /usr/local/etc/php.ini

# Clone Organizr git
# git clone https://github.com/causefx/Organizr/tree/v1-master.git /usr/local/www/Organizr
git clone https://github.com/causefx/Organizr.git /usr/local/www/Organizr

# Set permissions
chown -R www:www /usr/local/www

# Enable the service
sysrc nginx_enable=YES
sysrc php_fpm_enable=YES

# Start the service
service nginx start
service php-fpm start

# Complete message - Print below text
echo "Organizr Successfully Installed"
