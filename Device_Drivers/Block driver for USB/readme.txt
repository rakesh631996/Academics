Read me:
To build: make all
To insert module: sudo insmod ppp1.ko
To remove existing driver: sudo modprobe -rf usb_storage
To check registered block devices: sudo fdisk -l 
To mount the pendrive after plugin:  sudo mount -t vfat /dev/Pendrive1 /media/external -o uid=1000,gid=1000,utf8,dmask=027,fmask=137
To go to pendrive directory: cd /media/external
To create new directory: mkdir filename
To delete a file: rm filename
To edit a file with echo: echo "text words" > filename
To unmount the pendrive:sudo umount /dev/Pendrive1


INFO: task kworker/0:2:72 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.


