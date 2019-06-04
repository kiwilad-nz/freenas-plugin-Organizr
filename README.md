# Organizr for FreeNAS 11.2
This Installation method will create a Plugin that is fully configurable via the FreeNAS GUI and CLI (shell) Below creates the Jail, installs all dependencies, applications and will mount the pool and directories as required.
```
#
cd /tmp
wget https://raw.githubusercontent.com/kiwilad-nz/freenas-plugin-Organizr/master/Organizr.json
iocage fetch -P dhcp=on vnet=on bpf=yes allow_raw_sockets=1 -n Organizr.json --branch 'master'
rm /tmp/Organizr.json
iocage fstab -a organizr /mnt/RAID6/Apps/Organizr /config nullfs rw 0 0
#
```
Await the creation of the Jail until you have been provided the Admin portal address.

Organizr should now be available at http://organizr/

After you have completed the initial setup in the UI go back and do the following as some settings are stored in the config.php in the web directory such as homepage settings and email settings. If you ever need to recreate the jail you can omit the first 2 of the next 3 steps as this will link back to the saved settings.

```
cp -a /usr/local/www/Organizr/api/config/config.php /config/config.php
rm /usr/local/www/Organizr/api/config/config.php
```
```
ln -s /config/config.php /usr/local/www/Organizr/api/config/config.php
```
