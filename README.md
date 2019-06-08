# Organizr for FreeNAS 11.2
This Installation method will create a Plugin that is fully configurable via the FreeNAS GUI and CLI (shell) Below creates the Jail, installs all dependencies, applications and will mount the pool and directories as required.
```
# Section 1 - Install
cd /tmp
wget https://raw.githubusercontent.com/kiwilad-nz/freenas-plugin-Organizr/master/Organizr.json
iocage fetch -P dhcp=on vnet=on bpf=yes allow_raw_sockets=1 -n Organizr.json --branch 'master'
rm /tmp/Organizr.json
iocage fstab -a organizr /mnt/RAID6/Apps/Organizr /config nullfs rw 0 0
#
```
Await the creation of the Jail until you have been provided the Admin portal address.

Organizr should now be available at http://organizr/

After you have completed the initial setup in the WebUI, issue the below commands to backup this setup that are stored in the config.php within the web directory.
```
# Section 2 - Backup
iocage exec organizr cp -a /usr/local/www/Organizr/api/config/config.php /config/config.php
iocage exec organizr rm /usr/local/www/Organizr/api/config/config.php
iocage exec organizr ln -s /config/config.php /usr/local/www/Organizr/api/config/config.php
#
```
If you ever need to recreate the jail and restore the saved settings, use the below command and exclude section 2.
```
# Section 3 - Restore
iocage exec organizr ln -s /config/config.php /usr/local/www/Organizr/api/config/config.php
#
```
