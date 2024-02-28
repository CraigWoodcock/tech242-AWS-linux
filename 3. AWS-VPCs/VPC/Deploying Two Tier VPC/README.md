# Steps to Deploy Two Tier

- setup db vm first and then configure the app vm.
  - following the steps outlined here : [Two Tier Deployment](<../../../2. Two-Tier-Deployment/2 Tier Deployment>)
- when they are both working, make an ami from them both.

- create the vpc - CiDR 10.0.0.0/16
- define subnets
  - public subnet - CiDR 10.0.2.0/24 - make sure you enable public IPV4!!
  - private subnet - CiDR 10.0.3.0/24
- define security groups
- create internet gateway - attach to vpc
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