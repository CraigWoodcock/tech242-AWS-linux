#!/bin/bash

#
#This script is used to create an AWS AMI with Java17 and Apache web 
#server with reverse proxy configured to map port :8080 (default java port)
#
#
#update
echo "Updating Lists..."
echo " "
sudo apt update -y
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#upgrade
echo "Upgrading Lists..."
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#install jdk java 17
echo "Installing Java 17..."
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt install openjdk-17-jdk -y
echo -e "\x1b[32mJava Installed...\x1b[0m"
echo " "

#install AWS-CLI
echo "Installing AWS-CLI..."
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt install awscli -y
echo -e "\x1b[32mAWS-CLI Installed...\x1b[0m"
echo " "


#install apache web server
echo "Installing Apache web Server..."
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt install apache2  -y
echo -e "\x1b[32mApache Installed...\x1b[0m"
echo " "

#start apache
echo "starting & Enabling apache..."
sudo DEBIAN_FRONTEND=noninteractive systemctl start apache2
sudo DEBIAN_FRONTEND=noninteractive systemctl enable apache2
echo -e "\x1b[32mApache Enabled...\x1b[0m"
echo ""

# Enable Apache modules proxy and http
echo "Enabling Modules"
sudo a2enmod proxy
sudo a2enmod proxy_http
echo -e "\x1b[32mDone...\x1b[0m"

#Configure VirtualHost Config

if grep -q 'ProxyPass / http://localhost:8080/' /etc/apache2/sites-available/000-default.conf; then
    # The string exists, so nothing to do
    echo "Reverse proxy already configured."
else
    # reverse proxy not configured yet
	echo "configuring reverse proxy"
        sudo sed -i '/DocumentRoot \/var\/www\/html/ a\ ProxyPreserveHost On\nProxyPass \/ http:\/\/localhost:8080\/\nProxyPassReverse \/ http:\/\/localhost:8080\/\n' /etc/apache2/sites-available/000-default.conf
fi

# Restart Apache
echo "Restarting apache"
sudo systemctl restart apache2
echo -e "\x1b[32mDone...\x1b[0m"
echo " "