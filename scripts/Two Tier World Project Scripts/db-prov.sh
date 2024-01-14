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

#download world.sql
echo -e "\x1b[32mSaving File...\x1b[0m"
git clone https://github.com/CraigWoodcock/tech242-worldproject.git worldsql
echo -e "\x1b[32mFile Saved...\x1b[0m"
echo " "


# Run world.sql script
echo "Executing Script"
sudo mysql < worldsql/world.sql
echo "Script Executed... "


#set bind adress

echo "Set Bind IP..."

sudo sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
echo "Done...."

echo "Revoking Privileges..."
sudo mysql -e "REVOKE ALL PRIVILEGES ON *.* FROM 'root'@'%'; FLUSH PRIVILEGES;"
echo "Dropping User..."
sudo mysql -e "DROP USER IF EXISTS 'root'@'%';"
echo "creating user..."
sudo mysql -e "CREATE USER 'root'@'%' IDENTIFIED BY 'root';"
echo "Granting Privileges..."
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';"
echo "Grant Options..."
sudo mysql -e "GRANT GRANT OPTION ON *.* TO 'root'@'%';" 
echo "Flushing Privileges..."
sudo mysql -e "FLUSH PRIVILEGES;"
echo "Done..."


echo "Restarting MySQL..."
sudo systemctl restart mysql
echo "Done..."
echo " "

echo "made it to the end.... " 

