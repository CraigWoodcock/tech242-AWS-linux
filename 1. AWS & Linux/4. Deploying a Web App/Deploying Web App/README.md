# How to Deploy a Web App

## Deploying Web Application
1. The first step is to obtain or create a security key pair - we need this to login
   - we can obtain this from our system admin or management
   - we store the file in the .ssh folder on our local machine to ensure it's away from any possible version control repo's to minimize the risk of leaked credentials.
2. Log into AWS Console and create a new EC2 Instance following the steps here:
[Creating an EC2 Instance](<../../Day 2/AWS-EC2-Instance/Creating-an-EC2-Instance/README.md>)
   - We may need to create a new security group to allow other types of traffic, i.e port 80 for http traffic or 8080/5000 for java apps.
   - we use ubuntu 18.04 as th AMI to install nginx
3. Once the Vm has been created, we can plan and execute a script following the steps here: 
[Script](<../../Day 3/Scripts/README.md>)

- This is a script I used to deploy a java atlas web app: 

```
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
echo "Stopping Spring App..."
mvn spring-boot:stop
echo "DONE!! "


#start Spring Boot App
echo "Starting Spring App..."
mvn spring-boot:start
echo "DONE!! "
```