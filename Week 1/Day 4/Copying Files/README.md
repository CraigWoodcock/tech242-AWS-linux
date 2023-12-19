# Copying Files to VM

## Copying From Local Host

- use the `scp` command to copy files to from local host:
  - ```
    scp -r -i ~/.ssh/tech242.pem "/C/Users/Work Profile/Documents/app-code/jsonvoorhees-java-atlas-app" ubuntu@3.250.46.193:~
    ``` 

    - replacing `/C/Users/Work Profile/Documents/app-code/jsonvoorhees-java-atlas-app` with the path of the files you want to copy.

## Copying files from Remote Host

- We can copy files from Remote Host using `git clone`
  - ``` 
    #copy app code to this vm
    echo "Cloning files from git..."
    echo " "
    git clone https://github.com/CraigWoodcock/tech242-jsonvoorhees-app.git 
    echo -e "\x1b[32mDone...\x1b[0m"
    echo " "
    ``` 