# Reverse Proxy

## what is reverse proxy
 - means we can redirect traffic to certain ports without the user needing to specify the port number in the url.

## Steps to install apache manually.
- Install Apache:
  - Run `sudo apt update -y` to update lists
  - Run `sudo apt install apache2 -y` to install apache
  - Run `sudo systemctl start apache2` to start apache
  - Run `sudo systemctl enable apache2` to enable apache
  - Run `sudo systemctl status apache2` to check status
  - Install the following modules:
      - Run `sudo a2enmod proxy` 
      - Run `sudo a2enmod proxy_http`
  - Run `sudo nano /etc/apache2/sites-available/000-default.conf` to enter config file
  - paste in the following code snippet:
    ```
    ServerName <Replace with public IP>     
    ProxyPass / http://localhost:5000/     
    ProxyPassReverse / http://localhost:5000/     
    
    ```
   - Replace IP with your public IP 
   - Run `sudo systemctl restart apache2` to restart the service to reload configurations 
    

## Steps to Install and Configure apache in a Bash Script.

```
#!/bin/bash

PUBLIC_IP=$(curl -s https://httpbin.org/ip | jq -r '.origin')

#install apache web server
echo "Installing Apache web Server..."
echo " "
sudo DEBIAN_FRONTEND=noninteractive apt install apache2  -y
echo "\x1b[32mApache Installed...\x1b[0m"
echo " "

#start apache
echo "starting apache & Enabling apache..."
sudo DEBIAN_FRONTEND=noninteractive systemctl start apache2
sudo DEBIAN_FRONTEND=noninteractive systemctl enable apache2
echo "\x1b[32mApache Enabled...\x1b[0m"
echo ""

# Enable Apache modules proxy and http
echo "Enabling Modules"
sudo a2enmod proxy
sudo a2enmod proxy_http
echo "\x1b[32mDone...\x1b[0m"

#Configure VirtualHost Config

VHOST_CONF="/etc/apache2/sites-available/000-default.conf"
cat <<EOF | sudo tee "$VHOST_CONF" > /dev/null
<VirtualHost *:80>
    ServerName $PUBLIC_IP

    ProxyPass / http://localhost:5000/
    ProxyPassReverse / http://localhost:5000/

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Restart Apache
echo "Restarting apache"
sudo systemctl restart apache2
echo "echo "\x1b[32mDone...\x1b[0m""
echo " "

#change directory to springapi
echo "Changing Directory..."
echo " "
cd /tech242-jsonvoorhees-app/springapi
echo "\x1b[32mDone...\x1b[0m"
echo " "

# Stop Spring Boot App
echo "Stopping Spring App..."
echo " "
mvn spring-boot:stop
echo "\x1b[32mDone...\x1b[0m"
echo " "

#start Spring Boot App
echo "Starting Spring App..."
echo " "
mvn spring-boot:start
echo "\x1b[32mStarted\x1b[0m"
echo " "

```

  - This assumes that Java jdk 17 and Maven are installed
  - The `PUBLIC_IP` is set dynamically using the `curl` command
    - This means we dont need to know the Public IP before we create the insance and it will work if the IP changes.  