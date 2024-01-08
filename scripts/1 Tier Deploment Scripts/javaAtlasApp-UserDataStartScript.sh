#!/bin/bash

#change directory to springapi
echo "Changing Directory..."
echo " "
cd repo/springapi
echo -e "\x1b[32mDone...\x1b[0m"
echo " "

#start Spring Boot App
echo "Starting Spring App..."
echo " "
mvn spring-boot:start
echo -e "\x1b[32mSpring App Started....\x1b[0m"
echo " "