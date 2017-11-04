#!/bin/bash

echo "(Setting up your Vagrant box...)"

echo "(Updating apt-get...)"
sudo apt-get update > /dev/null 2>&1

# Apache
echo "(Installing Apache)"
sudo apt-get install -y apache2 > /dev/null 2>&1

# MySQL
echo "(Preparing for MySQL Installation...)"
sudo apt-get install -y debconf-utils > /dev/null 2>&1
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"

# MySql Server
echo "(Installing MySQL...)"
sudo apt-get install -y mysql-server > /dev/null 2>&1

# Php Modules
echo "(Installing PHP and MySQL module...)"
sudo apt-get install -y libapache2-mod-php php-mcrypt php-fpm php-mysql php-curl php7.0-xml php7.0-intl php7.0-gd php7.0-mbstring > /dev/null 2>&1

# Setting User
echo "(Setting Ubuntu (user) password to \"vagrant\"...)"
echo "ubuntu:vagrant" | chpasswd

# Setting Apache
echo "(Remove default Apache config and Restart Apache)"
sudo rm /etc/apache2/sites-enabled/000-default.conf
sudo service apache2 restart

# Cleaning Up
echo "(Cleaning up additional setup files and logs...)"
sudo rm -r /var/www/html

echo "+---------------------------------------------------------+"
echo "|                      S U C C E S S                      |"
echo "+---------------------------------------------------------+"
echo "|   You're good to go! You can now view your server at    |"
echo "|                 \"11.11.11.11/\" in a browser.              |"
echo "|                                                         |"
echo "|  If you haven't already, I would suggest editing your   |"
echo "|     hosts file with \"11.11.11.11  projectname.vagrant\"    |"
echo "|         so that you can view your server with           |"
echo "|      \"projectname.vagrant/\" instead of \"11.11.11.11/\"     |"
echo "|                      in a browser.                      |"
echo "|                                                         |"
echo "|          You can SSH in with ubuntu / vagrant           |"
echo "|                                                         |"
echo "|        You can login to MySQL with root / root          |"
echo "+---------------------------------------------------------+"
