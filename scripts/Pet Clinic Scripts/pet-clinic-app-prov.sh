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

#Updating Alternatives to use Java 17
echo -e "\x1b[34mUpdating Alternatives...\x1b[0m"
echo " "
sudo update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/java-17-openjdk-amd64/bin/javac
echo -e "\x1b[32mJava 17 set\x1b[0m"
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
git clone https://github.com/CraigWoodcock/spring-pet-clinic.git repo 
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

echo "renaming application-mysql.properties"
mv repo/src/main/resources/application-mysql.properties repo/src/main/resources/application.properties.b 

echo "renaming application-mysql.properties.bk"
mv repo/src/main/resources/application-mysql.properties.bk repo/src/main/resources/application-mysql.properties



#set env variables
echo "Setting ENV Variables"
export DB_HOST=jdbc:mysql://172.31.33.212:3306/petclinic
export DB_USER=petclinic
export DB_PASS=petclinic


echo -e "\x1b[32m$DB_HOST\x1b[0m"
echo -e "\x1b[32m$DB_USER\x1b[0m"
echo -e "\x1b[32m$DB_PASS\x1b[0m"
echo " "
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


#change directory to repo
cd repo
mvn clean package
java -jar target/*.jar --spring.profiles.active=mysql


