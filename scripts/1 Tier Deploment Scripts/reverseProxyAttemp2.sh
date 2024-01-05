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

#copy app code to this vm
echo "Cloning files from git..."
echo " "
git clone https://github.com/CraigWoodcock/tech242-jsonvoorhees-app.git 
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

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

VHOST_CONF="/etc/apache2/sites-available/000-default.conf"
cat <<EOF | sudo tee "$VHOST_CONF" > /dev/null
<VirtualHost *:80>
    
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html		
	

    ProxyPreserveHost On
    ProxyPass / http://localhost:5000/
    ProxyPassReverse / http://localhost:5000/

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Restart Apache
echo "Restarting apache"
sudo systemctl restart apache2
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#change directory to springapi
echo "Changing Directory..."
echo " "
cd /tech242-jsonvoorhees-app/springapi
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

# Stop Spring Boot App
echo "Stopping Spring App..."
echo " "
mvn spring-boot:stop
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#start Spring Boot App
echo "Starting Spring App..."
echo " "
mvn spring-boot:start
echo -e "\x1b[32mStarted\x1b[0m"
echo " "