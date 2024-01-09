

- [1. AWS and Linux](#1-aws-and-linux)
  - [1. Intro to Cloud \& AWS](#1-intro-to-cloud--aws)
  - [2. EC2 Instances \& Linux Commands](#2-ec2-instances--linux-commands)
  - [3. Scripts, Variables, Processes and Permissions](#3-scripts-variables-processes-and-permissions)
  - [4. Deploying Web App](#4-deploying-web-app)
  - [5. 1 Tier Deployment using AWS EC2 Instance](#5-1-tier-deployment-using-aws-ec2-instance)
- [2. 2 Tier Deployment](#2-2-tier-deployment)
  - [2 Tier Deployment Project](#2-tier-deployment-project)
- [3. AWS Virtual Private Cloud](#3-aws-virtual-private-cloud)
  - [AWS VPC's](#aws-vpcs)
- [4. AWS S3 Storage](#4-aws-s3-storage)
  - [AWS S3 Storage and CLI](#aws-s3-storage-and-cli)
- [5. AWS Monitoring \& Alert Management](#5-aws-monitoring--alert-management)
  - [Monitoring in AWS](#monitoring-in-aws)
- [6. Launch Templates \& Auto Scaling Groups](#6-launch-templates--auto-scaling-groups)
  - [Scaling, Launch Templates and Auto Scaling Groups](#scaling-launch-templates-and-auto-scaling-groups)
- [All Scripts](#all-scripts)


# 1. AWS and Linux
   ## 1. Intro to Cloud & AWS

  What is Cloud
  - [What is Cloud?](<1. AWS & Linux/1. Intro to Cloud & AWS/What-is-Cloud>)  
      - Cloud Basics
      - Benefits Of Cloud
      - Summary

  AWS Basics
  - [AWS Basics](<1. AWS & Linux/1. Intro to Cloud & AWS/AWS-Basics>)
      - What is AWS?
      - AWS Basics 

   ## 2. EC2 Instances & Linux Commands

  Creating an Instance
  - [Creating an EC2 Instance](<1. AWS & Linux/2. EC2 Instances & Linux Commands/AWS-EC2-Instance/Creating-an-EC2-Instance>)
      - How to create a EC2 Instance (VM)

  Connecting To an Instance   
  - [Connecting To an Instance](<1. AWS & Linux/2. EC2 Instances & Linux Commands/AWS-EC2-Instance/Connecting to an Instance>)
      - How to connect to the Instance (VM)

  Linux Commands  
  - [Linux commands](<1. AWS & Linux/2. EC2 Instances & Linux Commands/Linux Commands>)
      - Directory Commands
      - Linux Commands
      - Important Points 

  ## 3. Scripts, Variables, Processes and Permissions
  Scripts
  - [Scripts](<1. AWS & Linux/3. Scripts Variables Processes & Permissions/Scripts>)
    - How to make a script 

  Environment Variables
  - [Environment Variables](<1. AWS & Linux/3. Scripts Variables Processes & Permissions/Environment Variables>)
    - What are Environment Variables 

  Managing Processes  
  - [Managing Processes](<1. AWS & Linux/3. Scripts Variables Processes & Permissions/Managing Processes>)
    - Managing Processes
    - Viewing Processes

  Managing Permissions
  - [File Ownership and Permissions](<1. AWS & Linux/3. Scripts Variables Processes & Permissions/File Ownership and Permissions>)
    - Why File Ownership is Important
    - Default File Ownership and Permissions
    - Commands to Change Permissions
    
## 4. Deploying Web App
  Deploying Web App
  - [Deploying Web App](<1. AWS & Linux/4. Deploying a Web App/Deploying Web App>)
    - Creating Security Group
    - Deploying Web App
    - Automating Install Tasks 

  - [Copying Files](<1. AWS & Linux/4. Deploying a Web App/Copying Files>)
    - Copying from local to VM
    - Copying from remote to VM 

## 5. 1 Tier Deployment using AWS EC2 Instance
  - [1 Tier Deployment](<1. AWS & Linux/5. One Tier Deployment Project/1 Tier Deployment>)
    - 1 Tier Deployment
    - Full steps to deploy an app using an ami
    - Automated Script File
  
  - [Levels of Automation](<1. AWS & Linux/5. One Tier Deployment Project/Levels of Automation>)
    - Automation Levels
    - AMI Level 

  - [AMI Automation](<1. AWS & Linux/5. One Tier Deployment Project/AMI Automation>)
    - AMI Level
    - Steps To Automate Using AMI

  - [Apache Reverse Proxy](<1. AWS & Linux/5. One Tier Deployment Project/Apache Reverse Proxy>)
    - Reverse Proxy Script

  - [1 Tier Deployment Scripts](<1. AWS & Linux/5. One Tier Deployment Project/1 Tier Deploment Scripts>)
    
    - [Java Atlas App Script](<1. AWS & Linux/5. One Tier Deployment Project/1 Tier Deploment Scripts/JavaMavenSpringBashScript.sh>)
    
    - [Java Atlas App Apache Reverse Proxy IF Statement Script](<1. AWS & Linux/5. One Tier Deployment Project/1 Tier Deploment Scripts/javaAtlasReverseProxy-IFstatement.sh>)
    
    - [Java Atlas App User Data Start Script](<1. AWS & Linux/5. One Tier Deployment Project/1 Tier Deploment Scripts/javaAtlasApp-UserDataStartScript.sh>)
    
    - [Java Atlas App alt Reverse Proxy Script](<1. AWS & Linux/5. One Tier Deployment Project/1 Tier Deploment Scripts/reverseProxyAttemp2.sh>)



# 2. 2 Tier Deployment
## 2 Tier Deployment Project
- [Two Tier Deployment](<2. Two-Tier-Deployment/2 Tier Deployment>)
  - 2 Tier Deployment
  
- [APP VM Script](<Week 2/App VM>)
  - Application Tier VM Script
  - Current Status/Issues 

- [DB VM Script](<Week 2/DB VM>)
  - Application Tier VM Script
  - Current Status/Issues 
  
- [Two Tier World Project Scripts](<2. Two-Tier-Deployment/Two Tier World Project Scripts>)
  - [Application VM Script](<scripts/Two Tier World Project Scripts/app-prov.sh>)
  - [Database VM Script](<scripts/Two Tier World Project Scripts/db-prov.sh>)
  - [Application User Data Start Script](<scripts/Two Tier World Project Scripts/2tier-App-ami-user-data.sh>)

# 3. AWS Virtual Private Cloud
## AWS VPC's
  - [What is a VPC](<3. AWS-VPCs/VPC/What Is A VPC>)
   - What is a VPC?
   
  - [Deploying 2 Tier VPC](<3. AWS-VPCs/VPC/Deploying Two Tier VPC>)
    - Steps to Deploy a 2 Tier VPC

# 4. AWS S3 Storage
## AWS S3 Storage and CLI

- [What is S3?](<4. AWS-S3-Storage/What is AWS S3 Storage>)
  - What is AWS S3 Storage?

- [Using S3 In a CLI](<4. AWS-S3-Storage/How to Use S3 in a CLI>)   
  - How to use AWS S3 in a Command Line Interface 

- [S3 Storage Scripts](<4. AWS-S3-Storage/S3 Storage Scripts>)
  - [Script to Create Bucket, Upload Image to Bucket, Set Public Permissions and replace Image On Home Page](<4. AWS-S3-Storage/S3 Storage Scripts/use-s3-image.sh>)
  - [Script to Revert Changes to Home Page and Delete Bucket](<4. AWS-S3-Storage/S3 Storage Scripts/revertChangesScript.sh>)

# 5. AWS Monitoring & Alert Management
## Monitoring in AWS

- [Monitoring in AWS](<5. AWS-Monitoring-&-Alert-Management/Monitoring in AWS>)
  - What is Monitoring in AWS
  - Creating a Custom Dashboard

# 6. Launch Templates & Auto Scaling Groups
## Scaling, Launch Templates and Auto Scaling Groups

- [What is Scaling](<6. AWS-Auto-Scaling-Groups/What is Scaling>)
  - What is Scaling
  - Vertical Scaling
  - Horizontal Scaling
  

  .

- [Launch Templates & Auto Scaling Groups](<6. AWS-Auto-Scaling-Groups/Creating ASG & Launch Template>)
  - Prerequisites to creating Launch Templates
  - How To Create Launch Templates
  - How To Create Auto Scaling Groups 


  

# All Scripts

- [All Scripts](scripts)
