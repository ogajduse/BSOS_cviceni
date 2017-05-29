yum install httpd php
/etc/init.d/httpd start
chown -R student_bsos /var/www/
touch /var/www/html/phpinfo.php
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
#zmenit v confu ServerName a UseCanonicalName v /etc/httpd/conf/httpd.conf
/etc/init.d/httpd restart
echo "127.0.0.1 www.mujserver.cz" >> /etc/hosts
#mimo skript ekvivalent: sudo bash -c 'echo "127.0.0.1 www.mujserver.cz" >> /etc/hosts'
touch /var/www/html/index.html
####samostatny ukol####
echo "127.0.0.1 www.seznam.cz" >> /etc/hosts
echo "127.0.0.1 www.google.com" >> /etc/hosts

mkdir -p /var/www/google.com/public_html
chown -R student_bsos /var/www/google.com/public_html
touch /var/www/google.com/public_html/index.html
echo "Moskva" >> /var/www/google.com/public_html/index.html


mkdir -p /var/www/seznam.cz/public_html
chown -R student_bsos /var/www/seznam.cz/public_html
touch /var/www/seznam.cz/public_html/index.html
echo "Frantik Pepik" >> /var/www/seznam.cz/public_html/index.html
#pridat
NameVirtualHost www.seznam.cz:80
NameVirtualHost www.google.com:81
<VirtualHost www.seznam.cz:80>
        ServerAdmin webmaster@dummy-host.example.com
        DocumentRoot /var/www/seznam.cz/public_html/
        ServerName www.seznam.cz
</VirtualHost>

<VirtualHost www.google.com:81>
        ServerAdmin webmaster@dummy-host.example.com
        DocumentRoot /var/www/google.com/public_html/
        ServerName www.google.com
</VirtualHost>
###
/etc/init.d/httpd restart

curl www.google.com:81
curl www.seznam.cz:80

