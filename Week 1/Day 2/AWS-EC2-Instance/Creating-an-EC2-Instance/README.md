# Creating an AWS EC2 Instance (Virtual Machine)

## Steps :
- Log in to AWS 
- Next, we need to select the correct region
  - Change 'Region' to "Ireland - eu-west-1"<br>
    ![Region Screenshot](<../../../../readme-images/EC2 Screenshots/Screenshot 2023-12-13 152548.png>)

- Select 'EC2' From 'Recently Visited' tab or search for 'EC2' and choose the option that states "Virtual Servers in the Cloud"<br>
   ![Recently Visited](<../../../../readme-images/EC2 Screenshots/Screenshot 2023-12-13 153459.png>)
- Select 'Launch Instance'<br>
   ![Launch Instance](<../../../../readme-images/EC2 Screenshots/Screenshot 2023-12-13 153648.png>)
- Give the new Instance a meaningful name<br>
   ![Name](<../../../../readme-images/EC2 Screenshots/Screenshot 2023-12-13 153925.png>)
- Now Choose an AMI (Amazon Machine Image) - if using Ubuntu 18.04, see below for instructions!<br>
   ![AMI Image](<../../../../readme-images/EC2 Screenshots/Screenshot 2023-12-13 154301.png>)
- Instance type should be set to t2.micro (Free tier eligible)!
   ![t2 Image](<../../../../readme-images/EC2 Screenshots/Screenshot 2023-12-12 120747.png>)
- Select Key Pair (Login)..We use tech242. 
  - a key pair is a public key and private key, the private key should be stored as .pem file in     the .ssh folder on your local machine. It should be obtained from managament/admin.<br>
- Under Network Settings - select security group or create one. If creating, you will need to select Edit and change the group name and description<br>
   -  'Allow SSH traffic from' dropdown box should be changed to 'My IP'
   -  'Allow HTTP traffic from the internet'
   
      ![Security Group Image](<../../../../readme-images/EC2 Screenshots/Screenshot 2023-12-13 160118.png>)<br>
   - Next choose 'Edit' at the top of 'Network Settings' section
   - Change the group name to a meaningful name and give it a description (usually the same as the name)
      ![Security Group Name Image](<../../../../readme-images/EC2 Screenshots/Screenshot 2023-12-13 162409.png>)
- Check all details and then select 'Launch Instance' to create an instance.
- Next we need to start the VM. Navigate to 'Instances on the left hand side'
- We can search for the VM by typing the name of the Instance into the search bar at the top.
- Find the Instance in the list -> check the box on the left -> click 'Instance state' dropdown box -> ;'Start Instance'
- Wait a few seconds and then hit refresh
- Your VM should now be running!
  ![Alt text](<../../../../readme-images/EC2 Screenshots/Screenshot 2023-12-13 163012.png>)














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
![AMI Image](<../../../../readme-images/Screenshot 2023-12-12 115522.png>)