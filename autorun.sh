#!/bin/bash

##########################################
# c0ded by : alinko a.k.a shutdown57     #
##########################################
#~	DebsTool - Debian Server Tools      ~#
#~	Easy Configuration Debian Server    ~#
#~	Make Fast Your Work~ 				~#
#~	INDONESIAN LINUX CODE SECURITY		~#
#--------------linuXcode.org-------------#
touch /etc/debsetool/debsetool-remember.conf
source /etc/debsetool/debsetool-user.conf
source /etc/debsetool/debsetool-remember.conf
clear
a_remember(){
	echo -n "Remember Username & Password ? [y/n] "
read yn
if [[ $yn == "y" || $yn == "Y" ]]; then
	echo \# REMEMBER USERNAME  PASSWORD CONFIGURATION > /etc/debsetool/debsetool-remember.conf
	echo REMEMBER=YES > /etc/debsetool/debsetool-remember.conf
else
	touch /etc/debsetool/debsetool-remember.conf
	echo \# REMEMBER USERNAME  PASSWORD CONFIGURATION > /etc/debsetool/debsetool-remember.conf
	echo REMEMBER=NONE > /etc/debsetool/debsetool-remember.conf
fi
}
a_login(){
	echo "+-----------------------------+"
echo "|     WELCOME TO DEBSETOOL    |"
echo "+-----------------------------+"

echo -n "USERNAME :"
read u
echo -n "PASSWORD :"
read p

if [[ $u == $USERNAME && $p == $PASSWORD ]]; then
	a_remember
	bash /opt/debsetool/debsetool.sh
else
	echo "wrong Username or Password .."
fi
}
if [[ $REMEMBER == "YES" ]]; then
	bash /opt/debsetool/debsetool.sh
else
	a_login
fi
