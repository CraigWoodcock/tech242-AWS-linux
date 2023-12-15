/C/Users/Work Profile/Documents/app-code"

scp -r -i ~/.ssh/tech242.pem "/C/Users/Work Profile/Documents/app-code/jsonvoorhees-java-atlas-app" ubuntu@3.250.46.193:~


#!/bin/bash

#update
sudo apt update -y


#upgrade
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y


# install maven
sudo DEBIAN_FRONTEND=noninteractive apt install maven -y

#check maven is installed
mvn -v


#install jdk java 17
sudo DEBIAN_FRONTEND=noninteractive apt install openjdk-17-jdk -y


#check java is installed
java --version


#copy app code to this vm
git clone 

#change directory to springapi

cd jsonvoorhees-java-atlas-app/springapi/



## attempt 2
#!/bin/bash

#update
echo "Updating Lists..."
sudo apt update -y
echo "DONE!! "

#upgrade
echo "Upgrading Lists..."
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
echo "DONE!! "


# install maven
echo "Installing Maven..."
sudo DEBIAN_FRONTEND=noninteractive apt install maven -y
echo "DONE!! "


#check maven is installed
echo "Check Version Maven..."
mvn -v
echo "DONE!! "

#install jdk java 17
echo "Installing Java 17..."
sudo DEBIAN_FRONTEND=noninteractive apt install openjdk-17-jdk -y
echo "DONE!! "

#check java is installed
echo "Checking Java Version..."
java --version
echo "DONE!! "

#copy app code to this vm
echo "Cloning fils from git..."
git clone 
echo "DONE!! "


#change directory to springapi
echo "Cloning fils from git..."
cd jsonvoorhees-java-atlas-app/springapi/
echo "DONE!! "


# Stop Spring Boot App
echo "Stoping Spring App..."
mvn spring-boot:stop
echo "DONE!! "


#start Spring Boot App
echo "Starting Spring App..."
mvn spring-boot:start
echo "DONE!! "
