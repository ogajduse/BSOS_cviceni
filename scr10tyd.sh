seznamcz=$(dig +short www.seznam.cz | head -1)

# reset iptables
sudo /sbin/iptables -F
sudo /sbin/iptables -X
# list rules
sudo /sbin/iptables -L

# drop in&fwd packets
sudo /sbin/iptables -P INPUT ACCEPT
sudo /sbin/iptables -P OUTPUT DROP
sudo /sbin/iptables -P FORWARD DROP

# list rules
sudo /sbin/iptables -L

curl www.seznam.cz
ping -c 4 localhost

sudo /sbin/iptables -N tcp_pakety
sudo /sbin/iptables -A OUTPUT -p TCP -j tcp_pakety
sudo /sbin/iptables -A tcp_pakety -p TCP --dport 80 -j ACCEPT
sudo /sbin/iptables -A tcp_pakety -p TCP --dport 443 -j ACCEPT

# list rules
sudo /sbin/iptables -L

curl www.seznam.cz
curl $seznamcz

sudo /sbin/iptables -N udp_pakety
sudo /sbin/iptables -A OUTPUT -p UDP -j udp_pakety
sudo /sbin/iptables -A udp_pakety -p UDP --dport 53 -j ACCEPT

curl www.seznam.cz

sudo /sbin/iptables -N icmp_pakety
sudo /sbin/iptables -A OUTPUT -p ICMP -j icmp_pakety
sudo /sbin/iptables -A icmp_pakety -p ICMP --icmp-type 3 -j ACCEPT

ping -c 4 localhost

sudo /sbin/iptables -A icmp_pakety -p ICMP --icmp-type 0 -j ACCEPT
sudo /sbin/iptables -A icmp_pakety -p ICMP --icmp-type 8 -j ACCEPT
sudo /sbin/iptables -A icmp_pakety -p ICMP --icmp-type 11 -j ACCEPT

ping -c 4 localhost

sudo /sbin/iptables -F icmp_pakety
sudo /sbin/iptables -A icmp_pakety -p ICMP -j ACCEPT

ping -c 4 localhost

# start logging
sudo /sbin/iptables -N log_pakety

sudo /sbin/iptables -A log_pakety -p ICMP -i lo -j LOG

sudo /sbin/iptables -A INPUT -j log_pakety

sudo dmesg -c

ping -c 20 localhost

#####

# reset iptables
sudo /sbin/iptables -F
sudo /sbin/iptables -X

sudo /sbin/iptables -N dohled
sudo /sbin/iptables -A OUTPUT -d 147.229.149.123 -j dohled

