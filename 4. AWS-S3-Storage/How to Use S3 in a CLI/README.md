# Using S3 Storage in a CLI

## Using a CLI to Create Buckets 

1. First we need to run an AWS EC2 virtual machine and ssh into it using a CLI (Command Line Interface), I use Git bash, and install AWS CLI using the following command:
   - `sudo apt install awscli -y` - This may need to be modified to allow for no user interaction when adding it to a script file.

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