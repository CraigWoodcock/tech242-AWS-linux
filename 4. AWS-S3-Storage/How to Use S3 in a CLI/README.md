# Using S3 Storage in a CLI

## Using a CLI to Create Buckets 

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

4. Next, We need to check that our connection is established by running the following commands:
   - `aws s3 ls` - This will list all buckets in our AWS Account
   - `aws s3 help` - This lists all help options related to S3 

5. Now we can create a bucket like so:
   - `aws s3 mb s3://tech242-craig-first-bucket`
   - Now run `aws s3 ls` again to check that your bucket is in the list
   - We could also run `aws s3 ls s3://tech242-craig-first-bucket` - This wont work if the bucket is empty

6. We need to change the permissions of the bucket:
   - we can do that by running these commands:
   - Turn off Block Public Access.
   ```
   aws s3api put-public-access-block --bucket craig-testing-s3-bucket --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"
   ```
   - Set ACL to make Object Public.
   ```
   aws s3api put-object-acl --bucket craig-testing-s3-bucket --key image.jpg --acl public-read
   ```
   - Create a Policy for the bucket
   ```
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
   ```
   - Apply the Policy
   ```
   aws s3api put-bucket-policy --bucket craig-testing-s3-bucket --policy file://policy.json
   ```



7. Now we can create a file, add some text and upload it to the bucket to test the bucket further:
   - `echo new line of text > testfile.txt`
   - `aws s3 cp testfile.txt s3://bucketname `

8. We can run `aws s3 ls s3://bucketname` to check the contents of the bucket.