# Organizr for FreeNAS 11.2

This Installation method will create a Jail that is fully configurable via the FreeNAS GUI and CLI (shell)

```
cd /tmp
wget https://raw.githubusercontent.com/kiwilad-nz/freenas-plugin-Organizr/master/Organizr.json
iocage fetch -P dhcp=on vnet=on bpf=yes allow_raw_sockets=1 -n Organizr.json --branch 'master'
```
Await the creation of the Jail.

Create directories and mount storage as required for further setup of the application via FreeNAS before proceeding.

The config file for Organizr will need the below amended within the Jail:
SSH into the Jail and Create/replace /usr/local/etc/nginx/nginx.conf with the following. 
This is the default settings with comments removed and the bare minimum changes required to run Organizr.

```
mv /usr/local/etc/nginx/nginx.conf /usr/local/etc/nginx/nginx.conf.backup
cat > /usr/local/etc/nginx/nginx.conf


user www;
worker_processes 1;
events {
worker_connections 1024;
}
http {
include mime.types;
default_type application/octet-stream;
sendfile on;
keepalive_timeout 65;
server {
listen 80;
server_name localhost;
root /usr/local/www/Organizr;
location / {
index index.php index.html index.htm;
}
error_page 500 502 503 504 /50x.html;
location = /50x.html {
root /usr/local/www/nginx-dist;
}
location ~ \.php$ {
fastcgi_split_path_info ^(.+\.php)(/.+)$;
fastcgi_pass unix:/var/run/php-fpm.sock;
fastcgi_index index.php;
fastcgi_param SCRIPT_FILENAME $request_filename;
include fastcgi_params;
}
}
}
```

Create directories and mount storage as required for further setup of the application via FreeNAS.

```
service nginx start
service php-fpm start
```

Organizr should now be available at http://IP/ | http://organizr/

After you have completed the initial setup in the UI go back and do the following as some settings are stored in the config.php in the web directory such as homepage settings and email settings. If you ever need to recreate the jail you can omit the first 2 of the next 3 steps as this will link back to the saved settings.

```
cp -a /usr/local/www/Organizr/api/config/config.php /config/config.php
rm /usr/local/www/Organizr/api/config/config.php
ln -s /config/config.php /usr/local/www/Organizr/api/config/config.php
```
