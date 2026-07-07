#!/bin/bash

#update
echo -e "\x1b[32mUpdating Lists...\x1b[0m"
echo " "
sudo apt update -y
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#upgrade
echo -e "\x1b[32mUpgrading Packages...\x1b[0m"
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
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

#download User.sql
echo -e "\x1b[32mSaving SQL File...\x1b[0m"
curl -o user.sql https://raw.githubusercontent.com/CraigWoodcock/spring-pet-clinic/refs/heads/main/src/main/resources/db/mysql/user.sql
echo -e "\x1b[32mFile Saved...\x1b[0m"
echo " "

# Run User.sql
echo -e "\x1b[32mExecuting Script...\x1b[0m"
echo " "
sudo mysql < user.sql
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#set bind adress

echo -e "\x1b[32mSetting Bind IP...\x1b[0m"
echo " "
sudo sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

echo "Restarting MySQL..."
sudo systemctl restart mysql
echo "Done..."
echo " "

echo "made it to the end.... " 