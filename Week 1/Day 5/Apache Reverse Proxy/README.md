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
    