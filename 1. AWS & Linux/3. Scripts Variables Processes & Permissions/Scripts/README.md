.sh - shell script
nginx - system service -  needs restarting after reconfig
enabling - System processes - makes sure that the services run on startup
# Scripts
## What is Bash?
Bourne Again Shell (Bash) is a Unix shell and command language interpreter written by Brian Fox for the GNU Project as a free software replacement for the Bourne shell. It is the shell used by default in most Linux distributions. Bash is a powerful tool that can be used to automate tasks, write scripts, and manage data.

## How to Create a Bash Script.
1. From your terminal run command `nano <filename>.sh`
   - Depending on the location of the file, i.e root directory, we may need to run `sudo nano <filename>.sh` or log in as root `sudo su`
   - This will create a file named accordingly, with the .sh extension and will open a text editor.
2. Use Comments `#update packages`, `#upgrade packages` etc, to plan the commands we need to run.
   - Once we have our plan in place, we can save the file `ctrl+s` and exit the file `ctrl+x`  
3. Now we can run the commands one by one to make sure they work correctly!
   - If they do, add them to the `.sh` file (using the same `nano` command as before).
4. Once all commands have been executed succesfully, we are ready to execute the script.

## How to Execute a Bash Script.
Executing a script inside a linux terminal is a very simple process, However we should always be sure to execute the commands one at a time before adding them to a script to be sure that the commands work and that they achieve the required end goal.

1. We first need to give the file execute '`x`' permissions, we can use `chmod +x <filename>`
2. Now we execute the file using `./<filename>`
3. You will see the result of the commands being executed in the terminal. 
    

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
