
cat /proc/sys/fs/inotify/max_user_watches

sudo nano /etc/sysctl.conf
 >> fs.inotify.max_user_watches=1048576


sudo sysctl -p /etc/sysctl.conf

