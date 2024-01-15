

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
    echo -e "\x1b[32mString not found or pattern has changed...\x1b[0m"
fi

#search for and replace timestamp:mkmk

if grep -q '<h2>Updated 4/12/23 22:13</h2>' /repo/springapi/src/main/resources/templates/home.html; then
    # The string exists, replace it with the current date
    echo -e "\x1b[32mReplacing Timestamp with Current Date...\x1b[0m"
    sudo sed -i "s#<h2>Updated 4/12/23 22:13</h2>#<h2>Updated 04/01/2024 by C.W.</h2>#g" /repo/springapi/src/main/resources/templates/home.html
else
    # The string doesn't exist
    echo -e "\x1b[32mString not found or pattern has changed...\x1b[0m"
fi



#cd into repo to start repackage
cd /repo/springapi

#mvn package to refresh changes
sudo -E mvn package