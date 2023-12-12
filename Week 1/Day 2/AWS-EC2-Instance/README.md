# Creating an AWS EC2 Instance

## Steps :
- Log in to AWS 
- Change 'Region' to "Ireland - eu-west-1"
- Select 'EC2' From 'Recently Visited' tab or search for 'EC2' and choose the option that states "Virtual Servers in the Cloud"
- Select 'Launch Instance'
- Give the new Instance a meaningful name
- Now Choose an AMI (Amazon Machine Image) - if using Ubuntu 18.04, see below for instructions!
- Instance type should be set to t2.micro (Free tier eligible)!
- Select Key Pair (Login)..We use tech242. If you do not have access to the key then you will need to regenerate one








## AMI Ubuntu 18.04

- To use Ubuntu 18.04 we will need to search for the AMi using the below details:
   - We can search for the entire path or search by 'Filter for' value below
- In the AMI Section, choose Browse more AMIs
- Choose Community AMIs and paste in the path to search.
- select ubuntu 18.04
- Your screen should now look like the below example.


AMI ID = ending with 1e9 <br>
ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20230424 ami-0a7493ba2bc35c1e9<br>
Filter for 20230424<br>

Example of Ubuntu 18.04 AMI
![AMI Image](<../../../readme-images/Screenshot 2023-12-12 115522.png>)
