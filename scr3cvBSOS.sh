echo _______________________________________
/sbin/ip addr flush dev dummy0 #first flush
echo flushed, returned $?
echo _______________________________________
# /sbin/ifconfig dummy0 $1 netmask $2 #config
/sbin/ip addr add $1/$2 dev dummy0 
echo "$1/$2 added, returned $?"
echo _______________________________________
/sbin/ip addr show dummy0 | grep inet #show ip
echo _______________________________________
ping -c 2 $1 |grep $1
echo _______________________________________

