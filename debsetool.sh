#!/bin/bash

##########################################
# c0ded by : alinko a.k.a shutdown57     #
##########################################
#~	DebsTool - Debian Server Tools      ~#
#~	Easy Configuration Debian Server    ~#
#~	Make Fast Your Work~ 				~#
#~	INDONESIAN LINUX CODE SECURITY		~#
#--------------linuXcode.org-------------#

m="\033[1;31m"
k="\033[1;33m"
h="\033[1;32m"
b="\033[1;34m"
n="\033[1;0m"

a_cekKoneqzi(){
echo "Checking internet Connection..."
wget -q --tries=10 --timeout=20 --spider https://google.com
if [[ $? -eq 0 ]]; then
echo -e $h"[+] Yokatta ! You Are Online !"$n
sleep 2
else
echo -e $m"[-] Gomennasai.. You Are Offline :( OR You internet to slow.."
sleep 3
a_main
fi
}

a_confnet(){
	nano /etc/network/interfaces
	clear
	echo "[+] Restarting Networking..."
	/etc/init.d/networking restart
	sleep 2
}
a_confrep(){
	nano /etc/apt/sources.list
	clear
	echo "[+] Updating software..."
	apt-get update
	sleep 2
}
a_hostx(){
	if [[ `hostname` != `hostname -f` ]]; then
		clear
		echo "[+] hostname dan hostname -f tidak sama"
		echo "hostname    :"`hostname`
		echo "hostname -f :"`hostname -f`
		echo -n "[+] Configure hostname :"
		read h
		echo $h > /etc/hostname
		clear
		echo "restarting hostname.sh ..."
		/etc/init.d/hostname.sh start
		sleep 2
		echo -n "What You Wan't to Reboot ? [Y/n] "
		read c
		if [[ $c == "Y" || $c == "" || $c == "y" ]]; then
			reboot
		else
			clear
			a_main
		fi
	else
		echo "[+] Hostname & hostname -f sudah sama"
		sleep 5
	fi
}
a_localex(){
	clear
	echo "[+] Reconfiguring locales..."
	dpkg-reconfigure locales
	sleep 1
	clear
	echo "[+] Generating locales..."
	locale-gen
	sleep 1
}
a_intntp(){
	clear
	echo "[+] Installing ntp server..."
	apt-get install ntp
	sleep 2
	clear
	echo "[+] Configuring /etc/ntp.conf ..."
	sleep 1
	cat /etc/ntp.conf | grep debian
	if [[ "$?" -eq "0" ]]; then
		echo "[+] Found debian default ntp Configurationz ..."
		sleep 1
		echo "[+] Replacing debian to id ..."
		sed -i 's/debian/id/g' /etc/ntp.conf
		echo "[+] Replaced......................................................"
		sleep 1
		clear
		cat /etc/ntp.conf
		exit 0
	else
		echo "Can't Find debian Configurationz ..."
		sleep 1
		echo "Configure manual ..."
		sleep 1
		nano /etc/ntp.conf
	fi
	sleep 1
	echo "[+] Restarting Ntp service ..."
	/etc/init.d/ntp restart
	sleep 2
	clear
	echo "[+] Checking NTP status..."
	ntpq -p
	sleep 4
}
a_webserv(){
	apt-get install apache2
    sleep 2
    clear
    echo "---------------------------------------"
    echo "|          INSTALL PHP VERSION         |"
    echo "---------------------------------------"
    echo "[1] PHP5 | [2] PHP7 | [?] Default PHP5"
    echo -n "php :"
    read p
    if [[ $p == "1" ]]; then
    	echo "[+] Installing PHP5 and PHP5-EXTENSION ..."
    	apt-get install php5 php5-mysql php5-gd php5-json
    	apt-get install php5-mcrypt php5-xmlrpc php5-cli
    	apt-get install php5-intl php5-curl php5-pear php5-imagick
    	sleep 2
    	clear
    elif [[ $p == "2" ]]; then
    	 echo "[+] Installing PHP and PHP-EXTENSION ..."
    	apt-get install php php-mysql php-gd php-json
    	apt-get install php-mcrypt php-xmlrpc php-cli
    	apt-get install php-intl php-curl php-pear php-imagick
    	sleep 2
    	clear
    else
    	 echo "[+] Installing PHP5 and PHP5-EXTENSION ..."
    	apt-get install php5 php5-mysql php5-gd php5-json
    	apt-get install php5-mcrypt php5-xmlrpc php5-cli
    	apt-get install php5-intl php5-curl php5-pear php5-imagick
    	sleep 2
    	clear
    fi
    echo "-----------------------------------"
    echo "|      INSTALL DATABASE SERVER     |"
    echo "-----------------------------------"
    echo "[1] Mysql-server [2] mariadb-server [?] Default mariadb-server !"
    echo -n "DBserver :"
    read dbs
    if [[ $dbs == "1" ]]; then
    	clear
    	echo "[+] Installing Mysql-server ..."
    	apt-get install mysql-server
    elif [[ $dbs == "2" ]]; then
    	clear
    	echo "[+] Installing mariadb-server..."
    	apt-get install mariadb-server
    else
    	clear
    	echo "[+] Installing mariadb-server..."
    	apt-get install mariadb-server
    fi
    mysql_secure_installation
    clear
    sleep 1
    echo "[+] Installing phpmyadmin..."
    apt-get install phpmyadmin
    clear
    sleep 1
    echo "[+] Activating rewrite .htaccess ..."
    a2enmod rewrite
    sleep 2
}
a_sslx(){
	clear
    echo "[+] Generating Certificate..."
    openssl req -new -x509 -days 365 -nodes -out /etc/apache2/apache2.pem -keyout /etc/apache2/apache2.pem
    clear
    sleep 1
    echo "[+] Enable ssl mode..."
    a2enmod ssl
    sleep 2
    clear
    echo "[+] Add Listening Port 443 ... "
    echo Listen 443 >> /etc/apache2/ports.conf
    sleep 1
    clear
    echo "[+] View in site available , ...."
    ls /etc/apache2/sites-available/
    echo -n "sites-available config :"
    read sa
    nano /etc/apache2/sites-available/$sa
    sleep 1
    clear
    echo "[+] Restarting webserver..."
    /etc/init.d/apache2 restart
    sleep 1
    clear
}
a_samba(){
	clear
 	echo "[+] Installing Samba server..."
 	apt-get install samba
 	clear
 	sleep 1
 	echo "[+] Configuring samba server..."
 	echo \#SAMBA SERVER CONFIGURATION FILE BY ALINKO >> /etc/samba/smb.conf
 	nano /etc/samba/smb.conf
 	echo -n "[+] Samba User :"
 	read u
 	smbpasswd -a $u
 	if [[ "$?" -eq "0" ]]; then
 		echo "[+] Added User $u to samba server ..."
 	else
 		echo -n "[+] samba user :"
 		read x
 		smbpasswd -a $x
 	fi
 	sleep 2
 	clear
 	echo "[+] Restarting samba ..."
 	/etc/init.d/samba restart
 	sleep 2
}
a_fptd(){
	clear
	echo "[+] Installing Proftpd ..."
	apt-get install proftpd
	clear
	sleep 1
	echo "[+] Configuring proftpd ..."
	nano /etc/proftpd/proftpd.conf
	echo -n "Add user : "
	read ux
	adduser $ux
	echo "[+] Restarting proftpd service ..."
	/etc/init.d/proftpd restart
	sleep 2
}
a_dnsx(){
	echo "[+] Installing bind9 ..."
	apt-get install bind9
	sleep 2
	clear
	echo "[+] Configuring bind9 ..."
	sleep 1
	nano /etc/bind/named.conf.local
	sleep 1
	echo -n "[+] Copy db.local to : "
	read db
	cp /etc/bind/db.local /etc/bind/$db
	sleep 1
	echo -n "[+] Copy db.127 to  : "
	read dbx
	cp /etc/bind/db.127 /etc/bind/$dbx
	sleep 1
	clear
	nano /etc/bind/$db
	nano /etc/bind/$dbx
	echo "[+] Restarting service BIND9 ..."
	/etc/init.d/bind9 restart
	sleep 2
	clear
	echo "----------[ Checking Nslookup & Dig ]---------"
	echo -n "[+] domain name : "
	read dn
	echo "[+] NSLOOKUP FOR $dn ..."
	nslookup $dn
	sleep 1
	echo "[+] DIG FOR $dn ..."
	dig $dn
	sleep 1
}
a_mailx(){
	clear
	echo "[+] Installing {postfix,courier-pop,courier-imap} ..."
	apt-get install postfix courier-pop courier-imap
	sleep 2
	clear
	echo "[+] Make directory '/etc/skel/Maildir' ..."
	maildirmake /etc/skel/Maildir
	sleep 1
	clear
	echo "[+] Configuring mail ..."
	nano /etc/postfix/main.cf
	sleep 1
	clear
	echo "[+] Reconfiguring postfix ..."
	dpkg-reconfigure postfix
	sleep 1
	clear
	echo "[+] Restarting {postfix,courier-imap,courier-pop,bind9} ..."
	/etc/init.d/postfix restart
	/etc/init.d/courier-imap restart
	/etc/init.d/courier-pop restart
	/etc/init.d/bind9 restart
	sleep 1
	clear
	echo -n "Add user1 : "
	read us
	adduser $us
	echo -n "Add user2 : "
	read us2
	adduser $us2
	sleep 2
	clear
	echo "----- [ Installing WEBMAIL - squirrelmail ] -----"
	apt-get install squirrelmail
	sleep 1
	clear
	echo "[+] Including squirrelmail to apache2 configration ..."
	echo Include "/etc/squirrelmail/apache.conf" >> /etc/apache2/apache2.conf
	sleep 1
	clear
	echo "[+] Restarting service apache2 ..."
	/etc/init.d/apache2 restart
	sleep 1
	echo "[+] Create Symbolic link to '/var/www/html/mail' ..."
	ln -s /usr/share/squirrelmail /var/www/html/mail
	sleep 2
}
a_radiox(){
	clear
	echo "[+] Installing icecast2 ..."
	apt-get install icecast2
	sleep 2
	clear
	nano /etc/icecast2/icecast.xml
	clear
	echo "[+] Configuring icecast2 ..."
	nano /etc/default/icecast2
	clear
	echo "[+] Restarting service icecast2 ..."
	/etc/init.d/icecast2 restart
}
a_webmin(){
	clear
	a_cekKoneqzi
	echo "[+] Downloading webmin ..."
	wget http://prdownloads.sourceforge.net/webadmin/webmin_1.831_all.deb
	sleep 1
	clear
	echo "[+] Installing Dependencies ..."
	 apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl
	 apt-get install libpam-runtime libio-pty-perl apt-show-versions python
	 sleep 1
	 clear
	echo "[+] Checking For available file webmin_1.831_all.deb ..."
	sleep 2
	cekw=`ls` | grep "webmin_1.831_all.deb"
	if [[ $cekw -eq "0" ]]; then
		clear
		echo "[+] webmin_1.831_all.deb already exists ..."
		echo "[+] Installing Webmin ..."
		dpkg -i webmin_1.831_all.deb
	else
		clear
		echo "[-] File webmin_1.831_all.deb doesn't exists in this server .. "
		echo "[!] Download or Upload manualy to this server ..."

	fi
	sleep 1
}
a_nagios3(){
	clear
	a_cekKoneqzi
	sleep 2
	clear
	echo "[+] Installing nagios3 ..."
	apt-get install nagios3 nagios-nrpe-plugin
	sleep 3
	clear
	echo "[+] Modify user nagiosadmin to group www-data ..."
	usermod -a -G nagios www-data
	sleep 1
	clear
	echo "[+] Change Permission /var/lib/nagios ..."
	chmod -R +x /var/lib/nagios3
	sleep 1
	clear
	echo "[+] Replacing 0 to 1 to /etc/nagios3/nagios.cfg ..."
	sed -i 's/check_external_commands=0/check_external_commands=1/g'  /etc/nagios3/nagios.cfg
	sleep 3
	clear
	echo "[+] Restarting nagios3 service ..."
	/etc/init./nagios3 restart
	sleep 2
}
a_monitorix(){
	a_cekKoneqzi
	echo "[+] Downloading Monitorix ..."
	wget http://www.monitorix.org/monitorix_3.9.0-izzy1_all.deb
	sleep 1
	clear
	echo "[+] Installing Dependencies ..."
	apt-get install rrdtool perl libwww-perl libmailtools-perl libmime-lite-perl librrds-perl
	apt-get install libdbi-perl libxml-simple-perl libhttp-server-simple-perl libconfig-general-perl
	apt-get install libio-socket-ssl-perl
	sleep 2
	clear
	echo "[+] Checking For available file monitorix_3.9.0-izzy1_all.deb ..."
	sleep 2
	cekm=`ls` | grep "monitorix_3.9.0-izzy1_all.deb"
	if [[ $cekm -eq "0" ]]; then
		clear
		echo "[+] monitorix_3.9.0-izzy1_all.deb already exists ..."
		echo "[+] Installing Monitorix ..."
		dpkg -i monitorix_3.9.0-izzy1_all.deb
	else
		clear
		echo "[-] File monitorix_3.9.0-izzy1_all.deb doesn't exists in this server .. "
		echo "[!] Download or Upload manualy to this server ..."

	fi
}
a_asterisk(){
	 clear
	 echo "[+] Installing asterisk ..."
	 apt-get install asterisk
	 sleep 1
	 clear
	 echo \# ASTERISK FILE CONFIGURATION BY ALINKO >> /etc/asterisk/sip.conf
	 echo \# ASTERISK FILE CONFIGURATION BY ALINKO >> /etc/asterisk/extensions.conf
	 nano /etc/asterisk/sip.conf
	 nano /etc/asterisk/extensions.conf
	 sleep 2
	 clear
	 echo "[+] Restarting asterisk ..."
	 /etc/init.d/asterisk restart
	 sleep 2
	 a_main
}
a_main(){
		clear
echo -e $n"             _______________          |*\_/*|________      "
echo -e $n"            |  ___________  |  $k A $n   ||_/-\_|______  |     "
echo -e $n"            | |   >   <   | |  $k  L $n  | |   0   <   | |     "
echo -e $n"            | |     -     | |  $k I $n   | |     -     | |     "
echo -e $n"            | |   \___/   | |  $k  N $n  | |   \___/   | |     "
echo -e $n"            |_____|\_/|_____| $k K   $n  |_______________|     "
echo -e $n"             / ********** \....."$k"O"$n"..... / ********** \      "
echo -e $n"           /  ************  \        /  ************  \    "
echo -e $n"          --------------------      --------------------   "
echo -e $n"         +-----------------------------------------------+ "
echo -e $n"         |     -[$m Debian 8.6 Server "$n"|$b Auto ToOlz$n ]-      | "
echo -e $n"         |      $m  Author   :$k alinko a.k.a shutdown57$n     |"
echo -e $n"         |      $m  Version  :$k 1.0 IDLICO  $n                |"
echo -e $n"         |      $m Codename  :$k PemalazMaz  $n                |"
echo -e $n"         |$b   linuXcode.org -$h Learn Linux And Know Code$n   |"
echo -e $n"         +-----------------------------------------------+ "   
echo -e $m">]=======])"$b"---------------------------------------------"$m"([=======[<"$n
echo -e $n"["$b"1"$n"]$h Configure Network.           "$k" ~ "$n"["$b"11"$n"]$h DNS Server (bind9) "
echo -e $n"["$b"2"$n"]$h Configure Repository.        "$k" ~ "$n"["$b"12"$n"]$h Mail Server & Webmail "
echo -e $n"["$b"3"$n"]$h Check Hostname & Hostname -f "$k" ~ "$n"["$b"13"$n"]$h Radio Server (icecast2) "
echo -e $n"["$b"4"$n"]$h Configure locales            "$k" ~ "$n"["$b"14"$n"]$h Install Monitorix"
echo -e $n"["$b"5"$n"]$h Install NTP and Configure NTP"$k" ~ "$n"["$b"15"$n"]$h Install Webmin"
echo -e $n"["$b"6"$n"]$h Configure bash.bashrc        "$k" ~ "$n"["$b"16"$n"]$h VoIP (asterisk)"
echo -e $n"["$b"7"$n"]$h Auto Install WebServer       "$k" ~ "$n"["$b"17"$n"]$h Install Nagios3"
echo -e $n"["$b"8"$n"]$h Activate SSL (HTTPS)         "$k" ~ "$n"["$b"18"$n"]$h Coming Soon~"
echo -e $n"["$b"9"$n"]$h Samba Server                 "$k" ~ "$n"["$b"19"$n"]$n Coming Soon~"
echo -e $n"["$b"10"$n"]$h FTP Server (Proftpd)        "$k" ~ "$n"["$b"20"$n"]$n Coming Soon~"
echo -e -n $m"alinko"$k"@"$b"smkw9jepara$n : "
read pil
if [[ $pil == "1" ]]; then
	a_confnet
	a_main
elif [[ $pil == "2" ]]; then
	a_confrep
	a_main
elif [[ $pil == "3" ]]; then
	a_hostx
	a_main
elif [[ $pil == "4" ]]; then
	a_localex
	a_main
elif [[ $pil == "5" ]]; then
	a_intntp
	a_main
elif [[ $pil == "6" ]]; then
	nano /etc/bash.bashrc
	a_main
elif [[ $pil == "7" ]]; then
	a_webserv
	a_main
elif [[ $pil == "8" ]]; then
	a_sslx
	a_main
elif [[ $pil == "9" ]]; then
	a_samba
	a_main
elif [[ $pil == "10" ]]; then
	a_fptd
	a_main
elif [[ $pil == "11" ]]; then
	a_dnsx
	a_main
elif [[ $pil == "12" ]]; then
	a_mailx
	a_main
elif [[ $pil == "13" ]]; then
	a_radiox
	a_main
elif [[ $pil == "14" ]]; then
	a_monitorix
	a_main
elif [[ $pil == "15" ]]; then
	a_webmin
	a_main
elif [[ $pil == "16" ]]; then
	a_asterisk
	a_main
elif [[ $pil == "17" ]]; then
	a_nagios3
	a_main
else
	clear 
	a_main

fi
}
if [[ `whoami` == 'root' ]]; then
	a_main
else
	clear
	echo "[+] You Must Be root."
fi