sudo /sbin/iptables -L |grep "udp dpt:bootps"|grep ACCEPT #jeste overit jestli nevrati null
sudo /sbin/iptables -L |grep "udp dpt:tftp"|grep ACCEPT

#upravit configurak /etc/sysconfig/network-scripts/ifcfg-eth1
#BOOTPROTO=static
#HWADDR=08:00:27:e9:25:70
#NETMASK=255.255.255.0
#IPADDR=192.168.57.1

/etc/init.d/network restart # restart interface eth1, potazmo vsech

#poslouchat 10s, pak grepnout jestli obsahuje nasledujici
/usr/sbin/tcpdump -i eth1
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth1, link-type EN10MB (Ethernet), capture size 96 bytes
15:27:38.900891 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, Request from 08:00:27:c5:58:16 (oui Unknown), length: 548
15:27:42.908161 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, Request from 08:00:27:c5:58:16 (oui Unknown), length: 548
15:27:50.928966 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, Request from 08:00:27:c5:58:16 (oui Unknown), length: 548

mkdir -p ~/work/temp
cd ~/work/temp

#dat na verejny cloud syslinux...blabla a pak wget

unzip ../syslinux-3.83.zip 

make INSTALLROOT=~/work/syslinux local-install

mkdir -m ~/work/tftp

cp  ~/work/syslinux/usr/share/syslinux/{pxelinux.0,menu.c32,vesamenu.c32,mboot.c32,poweroff.com,reboot.c32} ~/work/tftp

mkdir -p ~/work/tftp/pxelinux.cfg
touch ~/work/tftp/pxelinux.cfg/default
echo "prompt 1" >> ~/work/tftp/pxelinux.cfg/default

cat > ~/work/dnsmasq.conf << EOF
interface=eth1
bind-interfaces
dhcp-leasefile=/tmp/dnsmasq.leases
dhcp-range=192.168.57.50,192.168.57.250,600
dhcp-boot=pxelinux.0
enable-tftp
tftp-root=/home/student_bsos/work/tftp
EOF

/usr/sbin/dnsmasq -C ~/work/dnsmasq.conf -d

cat >> ~/work/tftp/pxelinux.cfg/default << EOF
ui menu.c32
menu title BSOS startovaci server

# puvodni definice disketa

menu separator
label
menu label Konec:
menu disable

label poweroff
menu label Vypn^out PC
menu indent 1
kernel poweroff.com

label reboot
menu label ^Restartovat PC
menu indent 1
kernel reboot.c32
EOF

/usr/sbin/dnsmasq -C dnsmasq.conf -d

#presunout invaders do work
ar xv grub-invaders_1.0.0-10_i386.deb
tar -zxvf data.tar.gz 
mv ./boot/invaders.exec ~/work/tftp/

cat >> ~/work/tftp/pxelinux.cfg/default << EOF

label hrathru
menu label ^Hrat hru
menu indent 1
kernel mboot.c32
append invaders.exec
EOF

/usr/sbin/dnsmasq -C dnsmasq.conf -d





