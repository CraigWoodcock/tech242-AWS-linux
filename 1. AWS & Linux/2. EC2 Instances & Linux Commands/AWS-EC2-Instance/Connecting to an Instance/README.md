# Connecting to Your VM (EC2 Instance)

## Steps to Connect to your VM

- The First step is to ensure the .pem File is stored in our .SSH folder.
  - The .SSH folder is a hidden folder inside the home directory.
  - The .pem file is created when the Key Pair is created or can be obtained from management/admin
  - To do this, cut and paste the file from its current location into the .SSH folder

- Next we need to open 'Git Bash' and change directory into the .SSH Folder
  - Do this using `cd .ssh` from the root directory
  - Run the `ls -al` command to check for the .pem file, and to check it's permissions.
  - If the .pem file is there, it's permission will need to be changed to Read Only. Do by executing the `chmod 400 <Filename>` command.
![Alt text](<../../../../readme-images/Connection Screemshots/Screenshot 2023-12-13 171053.png>)

- Now we need to head to our AWS Client Portal to Start the Instance.
  - Once Logged in, Navigate to Instances and search for your VM
  - Mark the checkbox, select 'Instance State' and 'Start Instance'
    ![Alt text](<../../../../readme-images/Connection Screemshots/Screenshot 2023-12-13 171525.png>)

- Now Time to Connect!
  - Select 'Connect' at the top and copy of the last line of the xample url:
  - It should like a little like this:

      `ssh -i "~/.ssh/fileName"+rest of command` 

  - In your Bash terminal, still inside the .ssh directory, paste the url from the 'Connect' tab.
  - Hit Enter and your connection will be established.