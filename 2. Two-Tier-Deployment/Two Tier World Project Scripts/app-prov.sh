#!/bin/bash

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

# install maven
echo "Installing Maven..."
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt install maven -y
echo -e "\x1b[32mMaven Installed...\x1b[0m"
echo " "

#check maven is installed
echo "Check Version Maven..."
echo " "
mvn -v
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#install jdk java 17
echo "Installing Java 17..."
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt install openjdk-17-jdk -y
echo -e "\x1b[32mJava Installed...\x1b[0m"
echo " "

#check java is installed
echo "Checking Java Version..."
echo " "
java -version
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#install MySql server
echo -e "\x1b[32mInstalling MySql Server...\x1b[0m"
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt install mysql-server -y
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#start enable and check status
echo -e "\x1b[32mStarting Service, Checking Status...\x1b[0m"
echo " "
sudo systemctl is-active --quiet mysql || sudo systemctl start mysql sudo systemctl is-enabled --quiet mysql || sudo systemctl enable mysql
echo -e "\x1b[32mStarted and Enabled...\x1b[0m"
echo " "

#restart mysql server
echo -e "\x1b[32mRestarting Service...\x1b[0m"
sudo systemctl restart mysql
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#copy app code to this vm
echo "Cloning files from git..."
echo " "
git clone https://github.com/CraigWoodcock/tech242-worldproject.git repo 
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#set env variables
echo "Setting ENV Variables"
export DB_HOST=jdbc:mysql://172.31.39.44:3306/world
export DB_USER=root
export DB_PASS=root
export DB_IP=172.31.39.44
export DB_NAME=world
export MYSQL_PWD=root

echo -e "\x1b[32m$DB_HOST\x1b[0m"
echo -e "\x1b[32m$DB_USER\x1b[0m"
echo -e "\x1b[32m$DB_PASS\x1b[0m"
echo -e "\x1b[32mDone...\x1b[0m"


#install apache web server
echo "Installing Apache web Server..."
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt install apache2  -y
echo -e "\x1b[32mApache Installed...\x1b[0m"
echo " "

#start apache
echo "starting apache & Enabling apache..."
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

if grep -q 'ProxyPass / http://localhost:5000/' /etc/apache2/sites-available/000-default.conf; then
    # The string exists, so nothing to do
    echo "Reverse proxy already configured."
else
    # reverse proxy not configured yet
	echo "configuring reverse proxy"
    sudo sed -i '/DocumentRoot \/var\/www\/html/ a\ ProxyPreserveHost On\nProxyPass \/ http:\/\/localhost:5000\/\nProxyPassReverse \/ http:\/\/localhost:5000\/\n' /etc/apache2/sites-available/000-default.conf
fi


# Restart Apache
echo "Restarting apache"
sudo systemctl restart apache2
echo -e "\x1b[32mDone...\x1b[0m"
echo " "


# Check if connection to the database can be established
if mysql -u"$DB_USER" -h"$DB_IP" -e "use $DB_NAME"; then
    echo "Connected to the database. Starting the application..."
   #change directory to repo
    echo "Changing Directory"
    cd repo
    sudo -E mvn package spring-boot:start
else
    echo "Failed to connect to the database. Application start aborted."
fi
