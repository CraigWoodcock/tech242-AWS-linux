# Deploying a Two Tier VPC on AWS.

In order to deploy a two tier VPC architecture, we first need to have created an AMI from both our Database VM and our Application VM: 

- setup db vm first and then configure the app vm.
  - following the steps outlined here : [Two Tier Deployment](<../../../2. Two-Tier-Deployment/2 Tier Deployment>)
- when they are both working, make an ami from them both.

## Creating the VPC.

1. Sign into the AWS console and Go to 'VPC'
![VPC Search](<../../VPC screenshots/Screenshot 2023-12-22 113554.png>)

1. Select 'Create VPC' 
  - Choose 'VPC only'
  - Give the VPC a name
  - Set the CIDR block range to 10.0.0.0/16
  - Now choose 'Create VPC' <br>
![VPC Settings](<../../VPC screenshots/VPC_Settings.png>)

- We can then see our VPC settings and a resource map:
![VPC Resource Map](<../../VPC screenshots/VPC_Resource_Map.png>)

3. Next we need to define our Subnets.
  - On the Left hand menu under 'Virtual Private Cloud', select 'subnets'
  - Select 'Create Subnet'
  - Choose our VPC from the Dropdown box
  - give the subnet a name and select the CIDR ranges:
    - public_subnet - CIDR 10.0.2.0/24
    - private_subnet - CIDR 10.0.3.0/24
  - Choose the Availability zone
    - public_subnet - az 1a
    - private_subnet - az 1b
![subnet settings](<../../VPC screenshots/Subnet-settings.png>)

  - Once created, we need to enable public IPV4 on the public subnet:
    - go to the public subnet
    - select 'actions' -> 'edit subnet settings' -> 'Enable auto-assign public IPv4 address'
![ipv4 enabled](<../../VPC screenshots/ipv4-enabled.png>)

4. Next we need to define our Security Groups.
  - from the left hand menu under 'security -> Select 'security Groups'  
  - Select 'Create Security Group'
  - Choose a name for example 'db-vpc-sg'
  - Select our VPC from the dropdown box
  - Select 'Add Rule' to add an 'Inbound Rule'
  - add a rule to allow all traffic on port 3306 (MySQL)
  - add a rule to allow traffic from my IP on port 22 (http) (we can remove this rule later on!)
  - Now do the same to create an application security group but we need to add a rule to allow all traffic on port 80 (http)
![DB SG Settings](<../../VPC screenshots/DB-SG-settings.png>)
![App SG Settings](<../../VPC screenshots/APP-SG-Settings.png>)

5. Now we need to Create an Internet Gateway and attach it to our VPC.
  - From the left hand menu under 'Virtual Private cloud' - select 'Internet Gateway'
  - Select 'Create Internet Gateway'
  - Give it a name
  - Add a tag Key=Name value=name-of-IG
  - Select 'Create Internet Gateway' - you will be taken to the Internet Gateway settings.
  - Select 'Actions' -> 'Attach to VPC'
  - Select the VPC from the dropdown box and 'Attach internet gateway' 
![Attach IG](<../../VPC screenshots/Attach-IG.png>)



- create route table
- associate route table with public subnet and add route to internet gateway
- Launch DB AMI
  - select VPC from network settings
  - select correct subnet
  - select correct security group
  - Launch VM
  
[Full DB Script](<../../../scripts/Two Tier World Project Scripts/db-prov.sh>)

- Copy DB Private IP and add to user data start script
- Launch App AMI
  - select VPC from network settings
  - select correct subnet
  - select correct security group
  - Paste user data start script
  - Launch VM
 
[Full App Script](<../../../scripts/Two Tier World Project Scripts/2tier-App-ami-user-data.sh>)<br>
[App User Data Script](<../../../scripts/Two Tier World Project Scripts/2tier-App-ami-user-data.sh>)
- go to public_IP/city to see the app working