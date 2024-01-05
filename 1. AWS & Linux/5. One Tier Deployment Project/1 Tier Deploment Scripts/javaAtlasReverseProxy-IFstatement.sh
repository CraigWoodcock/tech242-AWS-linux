#!/bin/bash

#update
echo "Updating Lists..."
echo " "
sudo apt update -y
echo ""
echo -e "\x1b[32mUpdated...\x1b[0m"
echo ""

#upgrade
echo "Upgrading Lists..."
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
echo ""
echo -e "\x1b[32mUpgraded...\x1b[0m"
echo " "

# install maven
echo "Installing Maven..."
echo ""
sudo DEBIAN_FRONTEND=noninteractive apt install maven -y
echo ""
echo -e "\x1b[32mMaven Installed...\x1b[0m"
echo " "

#check maven is installed
echo "Check Version Maven..."
echo " "
mvn -v
echo ""
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#install jdk java 17
echo "Installing Java 17..."
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt install openjdk-17-jdk -y
echo ""
echo -e "\x1b[32mJava Installed...\x1b[0m"
echo " "

#check java is installed
echo "Checking Java Version..."
echo " "
java -version
echo ""
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#copy app code to this vm
echo "Cloning files from git..."
echo ""
git clone https://github.com/CraigWoodcock/tech242-jsonvoorhees-app.git repo
echo ""
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#install apache web server
echo "Installing Apache web Server..."
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt install apache2  -y
echo ""
echo -e "\x1b[32mApache Installed...\x1b[0m"
echo " "

#start apache
echo "starting apache & Enabling apache..."
sudo DEBIAN_FRONTEND=noninteractive systemctl start apache2
echo ""
echo -e "\x1b[32mApache Started...\x1b[0m"
echo ""
sudo DEBIAN_FRONTEND=noninteractive systemctl enable apache2
echo ""
echo -e "\x1b[32mApache Enabled...\x1b[0m"
echo ""

# Enable Apache modules proxy and http
echo "Enabling Modules"
sudo a2enmod proxy
sudo a2enmod proxy_http
echo ""
echo -e "\x1b[32mModules Enabled...\x1b[0m"
echo ""

#Configure VirtualHost Config

if grep -q 'ProxyPass / http://localhost:5000/' /etc/apache2/sites-available/000-default.conf; then
    # The string exists, so nothing to do
    echo -e "\x1b[32mReverse Proxy Is Already Configured...\x1b[0m"
else
    # reverse proxy not configured yet
echo -e "\x1b[32mConfiguring Reverse Proxy...\x1b[0m"
sudo sed -i '/DocumentRoot \/var\/www\/html/ a\ ProxyPreserveHost On\nProxyPass \/ http:\/\/localhost:5000\/\nProxyPassReverse \/ http:\/\/localhost:5000\/\n' /etc/apache2/sites-available/000-default.conf
fi
echo ""
echo -e "\x1b[32mConfigured...\x1b[0m"
echo ""

# Restart Apache
echo ""
echo "Restarting apache"
echo ""
sudo systemctl restart apache2
echo ""
echo -e "\x1b[32mApache Restarted...\x1b[0m"
echo ""

#change directory to springapi
echo ""
echo "Changing Directory..."
echo ""
cd repo/springapi
echo ""
echo -e "\x1b[32mDone...\x1b[0m"
echo ""

# Stop Spring Boot App
echo "Stopping Spring App..."
echo " "
mvn spring-boot:stop
echo ""
echo -e "\x1b[32mDone...\x1b[0m"
echo ""

#start Spring Boot App
echo "Starting Spring App..."
echo ""
mvn spring-boot:start
echo ""
echo -e "\x1b[32mSpring App Started...\x1b[0m"
echo ""