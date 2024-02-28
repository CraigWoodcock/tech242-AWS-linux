#!/bin/bash


#set env variables
echo "Setting ENV Variables"
export DB_HOST=jdbc:mysql://10.0.3.86:3306/mydb
export DB_USER=root
export DB_PASS=root
export DB_IP=10.0.3.86
export DB_NAME=mydb
export MYSQL_PWD=root


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

