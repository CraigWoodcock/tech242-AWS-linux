#!/bin/bash


#revert image changes

if grep -q '<img src="https://tech242-craig-cat-bucket.s3.eu-west-1.amazonaws.com/image.jpg" alt="Bear Image">' /repo/springapi/src/main/resources/templates/home.html; then
    # The modified string exists, revert it back
    echo -e "\x1b[32mReverting Image Replacement...\x1b[0m"
    sudo sed -i 's#<img src="https://tech242-craig-cat-bucket.s3.eu-west-1.amazonaws.com/image.jpg" alt="Bear Image">#<img src="/images/friday13th.jpg" alt="friday13thposter">#g' /repo/springapi/src/main/resources/templates/home.html
else
    # The modified string doesn't exist
    echo -e "\x1b[32mOriginal String not found or pattern has changed...\x1b[0m"
fi

#revert timestamp changes
if grep -q '<h2>Updated 04/01/2024 by C.W.</h2>' /repo/springapi/src/main/resources/templates/home.html; then
    # The string exists, revert it back
    echo -e "\x1b[32mReverting Timestamp...\x1b[0m"
    sudo sed -i 's#<h2>Updated 04/01/2024 by C.W.</h2>#<h2>Updated 4/12/23 22:13</h2>#g' /repo/springapi/src/main/resources/templates/home.html
else
    # The string doesn't exist
    echo -e "\x1b[32mOriginal String not found or pattern has changed...\x1b[0m"
fi

#remove bucket and contents
aws s3 rb s3://tech242-craig-cat-bucket --force

#cd into repo to start repackage
cd /repo/springapi

#mvn package to refresh changes
sudo -E mvn package