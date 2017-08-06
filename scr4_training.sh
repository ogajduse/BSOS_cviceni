netstat -a
echo _______________________________________
netstat --tcp
echo "Type "y" whenever you have established the FTP connection"
read y
[[ $y != "y" ]] && echo "exiting, run script again" && exit 1
echo _______________________________________
netstat --tcp
echo _______________________________________
netstat -i 
echo _______________________________________
traceroute www.feec.vutbr.cz
echo _______________________________________
traceroute www.inf.upol.cz
echo _______________________________________
traceroute www.seznam.cz
echo _______________________________________
traceroute www.idnes.cz
echo _______________________________________
whois www.feec.vutbr.cz
echo _______________________________________
whois www.seznam.cz
echo _______________________________________
/sbin/ifconfig
touch /etc/sysconfig/network-scripts/ifcfg-dummy0
chmod 777 /etc/sysconfig/network-scripts/ifcfg-dummy0
cat > ~/work/dnsmasq.conf << EOF
DEVICE=dummy0
BOOTPROTO=static
IPADDR=192.168.5.5
NETMASK=255.255.255.0
EOF

/sbin/modprobe -o dummy dummy0
/etc/init.d/network restart
/sbin/ifconfig dummy0
ping -c 4 192.168.5.5
/sbin/ifconfig dummy0 192.168.10.10 netmask 255.255.255.0
/sbin ifconfig dummy0
ping -c 4 192.168.10.10

