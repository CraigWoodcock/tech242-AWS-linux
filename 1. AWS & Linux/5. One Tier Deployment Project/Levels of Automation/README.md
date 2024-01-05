# Levels of Automation

## Manual Level
- Manually Test.
      - Use SSH method to log into terminal and VM 
      - Manually test every command to make sure it works
      - Add each command to a script file
  
## Run Level
- Run Scripts
    - Use SSH method to connect to VM 
    - Use `nano` to create a prov-app.sh (bash script)
    - paste in the contents of your bash script file
    - give your prov-app.sh execute permissions
    - execute file in the terminal to make sure everything works.

## User Data Level
- User Data
    -  Log into AWS and create a new Instance
    -  During setup, we need to expand the 'advanced settings' tab
    -  In the 'User Data' section, Paste in the contents of your bash script to make sure it works

## AMI Level
- AMI Instance
  - Create an AMI image from the running instance in the User Data Level
  - use this AMi to launch a new instance
  - expand user details
  - Add you shebang `#!/bin/bash`
  - cd into correct repo
  - enter `sudo mvn spring-boot:start` command 
  - Launch instance to make sure it works
  - navigate to public IP.
