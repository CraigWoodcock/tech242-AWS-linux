# Creating an AWS EC2 Instance (Virtual Machine)

## Steps :
- Log in to AWS 
- Change 'Region' to "Ireland - eu-west-1"
- Select 'EC2' From 'Recently Visited' tab or search for 'EC2' and choose the option that states "Virtual Servers in the Cloud"
- Select 'Launch Instance'
- Give the new Instance a meaningful name
- Now Choose an AMI (Amazon Machine Image) - if using Ubuntu 18.04, see below for instructions!
- Instance type should be set to t2.micro (Free tier eligible)!
- Select Key Pair (Login)..We use tech242. If you do not have access to the key then you will need to regenerate one (a key pair is a public key and private key, the private key should be stored as .pem file in the .ssh folder)
- Select security group or create one. If creating, you will need to select Edit and change the group name and description
- Check all details and then select 'Launch Instance' to create an instance.
- Next we need to start the VM. Navigate to 'Instances on the left hand side'
- We can search for the VM by typing the name of the Instance into the search bar at the top.
- Find the Instance in the list -> check the box on the left -> click 'Instance state' dropdown box -> ;'Start Instance'
- Wait a few seconds and then hit refresh
- Your VM should now be running!













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

Example of Ubuntu 18.04 AMI<br>
![AMI Image](<../../../readme-images/Screenshot 2023-12-12 115522.png>)
