# Replacing an Image Using AWS CLI and S3

In this Project, I was tasked with creating an EC2 Instance and an s3 bucket, SSH into the EC2, downloading an image from the internet, uploading the image to the S3 Bucket and then changing the image in the home.html file with the image in the bucket.

we can do this manually by following the steps here:<br>
[How to use S3 in a CLI](<../How to Use S3 in a CLI>)


## Steps to Automate the Process

1. First we need to run an AWS EC2 virtual machine and ssh into it using a CLI (Command Line Interface), I use Git bash, and install AWS CLI using the following command:
   - `sudo apt install awscli -y` - This may need to be modified to allow for no user interaction when adding it to a script file.
   - we could use `sudo DEBIAN_FRONTEND=noninteractive apt install awscli -y`

2. Next we can check the installation by running this command:
   - `aws --version`

3. Now we need to log into our aws account using secure keys provided by management/administrators:
   - Run `aws configure`,
   - Enter Access Key Id and press 'enter'
   - Enter Secret Access Key and press 'enter'
   - Enter region code `eu-west-1`
   - For 'Output Format' enter `json`

4. Next we make a script file called `use-s3-image.sh`
   - Give the file execute permissions `sudo chmod +x`

5. Open the file and paste the following script:
   - This also changes the timestamp on the home screen.
```
#!/bin/bash

#create bucket
echo -e "\x1b[32mCreating Bucket......\x1b[0m"
echo ""
aws s3 mb s3://craig-testing-s3-bucket
echo""
echo -e "\x1b[32mCreated New Bucket...\x1b[0m"
echo""


# download image and upload to bucket
# save image as image.jpg 
echo -e "\x1b[32mDownloading Image...\x1b[0m"
echo""
curl -s https://i.pinimg.com/originals/75/d1/2f/75d12f2b01beba0e1a0979e506efc530.jpg | aws s3 cp - s3://craig-testing-s3-bucket/image.jpg
echo""
echo -e "\x1b[32mImage Downloaded and uploaded to S3...\x1b[0m"

#turn off block public access

echo -e "\x1b[32mTurn off Public Access....\x1b[0m"
aws s3api put-public-access-block --bucket craig-testing-s3-bucket --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"
echo -e "\x1b[32mDone...\x1b[0m"
echo -e ""

#set acl to make object public
aws s3api put-object-acl --bucket craig-testing-s3-bucket --key image.jpg --acl public-read

#
echo -e "\x1b[32mApplying policy content...\x1b[0m"
POLICY_CONTENT='{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::craig-testing-s3-bucket/*"
            ]
        }
    ]
}'

echo "$POLICY_CONTENT" > policy.json

echo -e "\x1b[32mPolicy.json Created...\x1b[0m"

aws s3api put-bucket-policy --bucket craig-testing-s3-bucket --policy file://policy.json
echo -e "\x1b[32mBucket Policy Applied...\x1b[0m"



# search for and replace image

if grep -q '<img src="/images/friday13th.jpg" alt="friday13thposter">' /repo/springapi/src/main/resources/templates/home.html; then
    # The string exists, replace it
    echo -e "\x1b[32mReplacing Image...\x1b[0m"
    sudo sed -i 's#<img src="/images/friday13th.jpg" alt="friday13thposter">#<img src="https://craig-testing-s3-bucket.s3.eu-west-1.amazonaws.com/image.jpg" alt="Bear Image">#g' /repo/springapi/src/main/resources/templates/home.html
else
    # The string doesn't exist
    echo -e "\x1b[32mImage Not Changed...\x1b[0m"
fi

#search for and replace timestamp:

if grep -q '<h2>Updated 4/12/23 22:13</h2>' /repo/springapi/src/main/resources/templates/home.html; then
    # The string exists, replace it with the current date
    echo -e "\x1b[32mReplacing Timestamp with Current Date...\x1b[0m"
    sudo sed -i "s#<h2>Updated 4/12/23 22:13</h2>#<h2>Updated 04/01/2024 by C.W.</h2>#g" /repo/springapi/src/main/resources/templates/home.html
else
    # The string doesn't exist
    echo -e "\x1b[32mTimeStamp Not Changed...\x1b[0m"
fi

#cd into repo to start repackage
cd /repo/springapi

#mvn package to refresh changes
sudo -E mvn package
```

6. Now execute the script
   - `./use-s3-image.sh`

7. Go to the public ip of the EC2 in a web browser to see the changes:<br>
![Replaced](<Screenshots/Screenshot 2024-01-15 221347.png>)


## Now We Can Revert the Changes

1. Next we make a script file called `revert-s3-image.sh`
   - Give the file execute permissions `sudo chmod +x`

2. Open the file and paste the following script:
   - This replaces the original image
   - Replaces the original timestamp
   - Removes all files from the bucket and deletes the bucket
```
#!/bin/bash


#revert image changes

if grep -q '<img src="https://craig-testing-s3-bucket.s3.eu-west-1.amazonaws.com/image.jpg" alt="Bear Image">' /repo/springapi/src/main/resources/templates/home.html; then
    # The modified string exists, revert it back
    echo -e "\x1b[32mReverting Image Replacement...\x1b[0m"
    sudo sed -i 's#<img src="https://craig-testing-s3-bucket.s3.eu-west-1.amazonaws.com/image.jpg" alt="Bear Image">#<img src="/images/friday13th.jpg" alt="friday13thposter">#g' /repo/springapi/src/main/resources/templates/home.html
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
aws s3 rb s3://craig-testing-s3-bucket --force

#cd into repo to start repackage
cd /repo/springapi

#mvn package to refresh changes
sudo -E mvn package
```
4. Go to the public IP to see the reverted changes:<br>
![reverted](<Screenshots/Screenshot 2024-01-15 224146.png>)