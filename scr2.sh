/usr/sbin/useradd uzivatel
/usr/sbin/groupadd skupina_uzivatelu
ls -l /home/ | grep uzivatel && echo - user exists
grep skupina_uzivatelu /etc/group && echo - group exists
/usr/sbin/usermod -G skupina_uzivatelu uzivatel
groups uzivatel | grep skupina_uzivatelu && echo user is in the right group
/usr/sbin/useradd uzivatel2 -G skupina_uzivatelu
groups uzivatel2 | grep skupina_uzivatelu && echo user is in the right group
cd ~
mkdir sdileny_adresar
chgrp skupina_uzivatelu sdileny_adresar
chmod 070 sdileny_adresar
ls -l sdileny_adresar
cd sdileny_adresar
sudo -u uzivatel -H sh -c "touch nazev_souboru"
sudo -u uzivatel2 -H sh -c "echo "text" > nazev_souboru"
printf "current user is: " && id
cd ..
chmod g+s sdileny_adresar
cd sdileny_adresar
sudo -u uzivatel -H sh -c "touch nazev_souboru2"
ls -l | grep -e nazev_souboru2 -e skupina_uzivatelu
sudo -u uzivatel2 -H sh -c "echo "newline" >> nazev_souboru2"
sudo -u uzivatel2 -H sh -c "touch nazev_souboru3"
ls -l | grep -e nazev_souboru3 -e skupina_uzivatelu
sudo -u uzivatel -H sh -c "echo "newline" >> nazev_souboru3"

cd ~
mkdir sdileny_adresar2
chgrp skupina_uzivatelu sdileny_adresar2
chmod 070 sdileny_adresar2
chmod g+s sdileny_adresar2
/usr/sbin/useradd uzivatel3
cd sdileny_adresar2
sudo -u uzivatel3 -H sh -c "touch testfile"
sudo -u uzivatel -H sh -c "touch testfile_uzivatel && echo output > testfile_uzivatel && grep output testfile_uzivatel"

