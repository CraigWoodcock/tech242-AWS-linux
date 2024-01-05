#!/bin/bash

#update
echo "Updating Lists..."
echo " "
sudo apt update -y
echo "DONE!! "
echo " "

#upgrade
echo "Upgrading Lists..."
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
echo "DONE!! "
echo " "


# install maven
echo "Installing Maven..."
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt install maven -y
echo "DONE!! "
echo " "


#check maven is installed
echo "Check Version Maven..."
echo " "
mvn -v
echo "DONE!! "
echo " "

#install jdk java 17
echo "Installing Java 17..."
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt install openjdk-17-jdk -y
echo "DONE!! "
echo " "

#check java is installed
echo "Checking Java Version..."
echo " "
java -version
echo "DONE!! "
echo " "

#copy app code to this vm
echo "Cloning files from git..."
echo " "
git clone https://github.com/CraigWoodcock/tech242-jsonvoorhees-app.git 
echo "DONE!! "
echo " "


#change directory to springapi
echo "Cloning files from git..."
echo " "
cd tech242-jsonvoorhees-app/springapi
echo "DONE!! "
echo " "


# Stop Spring Boot App
echo "Stopping Spring App..."
echo " "
mvn spring-boot:stop
echo "DONE!! "
echo " "


#start Spring Boot App
echo "Starting Spring App..."
echo " "
mvn spring-boot:start
echo "DONE!! "
echo " "
