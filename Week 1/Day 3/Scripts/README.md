.sh - shell script

nginx - system service -  needs restarting after reconfig
enabling - System processes - makes sure that the services run on startup

# What is Bash?
Bourne Again Shell (Bash) is a Unix shell and command language interpreter written by Brian Fox for the GNU Project as a free software replacement for the Bourne shell. It is the shell used by default in most Linux distributions. Bash is a powerful tool that can be used to automate tasks, write scripts, and manage data.

# How to Create a Bash Script.
- From your terminal `nano <filename>.sh`
  - This will create a file named accordingly, with the .sh extension
    

- `!#/bin/bash` - This line must be added to the script file. It indicates that it is a bash (*Bourne Again Shell*) script 

- Example bash script to install nginx

    ```
    #!/bin/bash

    # update
    echo "Update..."
    sudo apt update -y
    echo "Done!"
    echo "" 

    # upgrade
    echo "Upgrade..."
    sudo apt upgrade -y
    echo "Done!"
    echo "" 

    # install nginx
    echo "Installing nginx..."
    sudo apt install nginx -y
    echo "Done!"
    echo "" 

    # restart nginx
    echo "Restarting nginx..."
    sudo systemctl restart nginx
    echo "Done!"
    echo ""

    # enable nginx
    echo "Enableing nginx..."
    sudo systemctl enable nginx
    echo "Done!"
    echo ""
    ```
