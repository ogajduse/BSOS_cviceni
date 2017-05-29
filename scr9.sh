#stahnout si soubory z elearningu do ~

mv chroot.sh /var
mkdir ~/chroot
tar xvzf chroot_linux.tgz -C ~/chroot
sh /var/chroot.sh
#od tohoto mista prikazy v chroot
export PATH=$PATH:/usr/sbin/:/sbin
echo 'student:!!:501:501:Student:/home/student:/bin/bash' >> /etc/passwd
mkdir -p /home/student
'student:x:501:' >> /etc/group
passwd student
grep '^root\|^student' /etc/passwd
touch /etc/shadow
chmod 400 /etc/shadow
echo 'ucitel:x:502:502:Monter Vaclav:/home/ucitel:/bin/bash' >> /etc/passwd
pwconv
useradd -c Studentka -g student -m -n studentka
passwd studentka
pwunconv
chmod 777 /etc/
su student
cd /etc
john -wordfile:/usr/share/dict/words /etc/passwd
pwconv
unshadow /etc/passwd /etc/shadow > /tmp/hesla.txt
john -single /tmp/hesla.txt 

