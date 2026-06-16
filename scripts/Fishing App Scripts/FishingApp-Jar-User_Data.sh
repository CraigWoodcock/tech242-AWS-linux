#!/bin/bash


#set env variables
echo "Setting ENV Variables"
export DB_HOST=jdbc:mysql://172.31.21.136:3306/fishing_app
export DB_USER=root
export DB_PASS=rootpassword
export DB_IP=172.31.21.136
export DB_NAME=fishing_app
export JWT_SECRET=your_very_long_and_very_secure_secret_key_that_is_at_least_256_bits
export MYSQL_PWD=rootpassword

aws s3 cp s3://fishingappjars/fishingAppJarf749bf36.jar fishingapp.jar

java -jar fishingapp.jar &
