env = print env variables list

used to store sensitive information such as credentials

```
echo "Setting ENV Variables"
export DB_HOST=jdbc:mysql://172.31.38.160:3306/world
export DB_USER=root
export DB_PASS=root
export DB_IP=172.31.38.160
export DB_NAME=world
export MYSQL_PWD=root

echo -e "\x1b[32m$DB_HOST\x1b[0m"
echo -e "\x1b[32m$DB_USER\x1b[0m"
echo -e "\x1b[32m$DB_PASS\x1b[0m"
echo -e "\x1b[32mDone...\x1b[0m"
```