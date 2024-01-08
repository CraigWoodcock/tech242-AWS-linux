# Creating Auto Scaling Groups and Launch Templates

## Prerequisites
In order to create an ASG, we first need to ensure we have completed the following steps:

1. We have launched an EC2 Instance (Virtual Machine (VM)).
   - This should be launched using a fully working script in user data to minimize deployment time.
2. An AMI (Amazon Machine Image) has then been created from the running VM.
   - Once the AMI is 'available', we can terminate the running VM. 
4. We then need to create a Launch Template from the AMI.
5. Next we Need to Launch an Instance from the Launch Template to test it is working correctly.
   
With All of the above steps complete, we can move on to Creating Auto Scaling Groups.<br> 

So how do we create a Launch Template?

## How To Create a Launch Template

1. Select Launch Template from the Left Hand menu - under Instances
![Launch Template](<../ASG Screenshots/Launch Templates/Screenshot 2024-01-05 143925.png>)

- Then Select Create Launch Template<br>

![Create Template](<../ASG Screenshots/Launch Templates/Screenshot 2024-01-05 143940.png>)

2. Give your template a name <br>
![Name](<../ASG Screenshots/Launch Templates/Screenshot 2024-01-05 144103.png>)

3. Select your AMi<br>
![AMI](<../ASG Screenshots/Launch Templates/Screenshot 2024-01-05 144214.png>)

4. Select Instance Type and Key Pair<br>
![Key Pair](<../ASG Screenshots/Launch Templates/Screenshot 2024-01-05 144322.png>) 

5. Select You Security Group, Leave subnet as is.<br>
![SG](<../ASG Screenshots/Launch Templates/Screenshot 2024-01-05 144431.png>)

6. Add User Data To start programme.<br>
![User Data](<../ASG Screenshots/Launch Templates/Screenshot 2024-01-05 144526.png>)

7. Our template has been created, View Launch Templates Now.<br>
![Created](<../ASG Screenshots/Launch Templates/Screenshot 2024-01-05 144725.png>)

8. Select the template, choose actions, and 'Launch instance from template'<br>
![Instance from template](<../ASG Screenshots/Launch Templates/Screenshot 2024-01-05 144915.png>)

9. Add a Resource tag so our instance has a name, then launch instance to test it is working<br>
![Resource Tag](<../ASG Screenshots/Launch Templates/Screenshot 2024-01-05 145055.png>)

## How To Create Auto Scaling Groups

1. Select 'Auto Scaling Groups' from the Bottom of the left hand menu.<br>
 - Then Select 'Create Auto Scaling Group'.
 ![Create Auto Scaling Group](<../ASG Screenshots/ASG Creation/Screenshot 2024-01-05 150709.png>)

2. Select the Launch Template that we created.<br>
 - Then hit next.  
 ![LT Selection](<../ASG Screenshots/ASG Creation/Screenshot 2024-01-05 150805.png>)   

3. Select 'Availability Zones and Subnets'.<br>
 - Here we are using "DevOps Student Default 1a, 1b 1,c".<br>
 ![AZ Selection](<../ASG Screenshots/ASG Creation/Screenshot 2024-01-05 151037.png>)

4. We need to attach a new Load Balancer.<br>
  - It Needs to be an 'Application Load Balancer' for 'HTTP/HTTPS.<br>
  - Give it a name and make it 'internet facing'<br> 
 ![LB Attach](<../ASG Screenshots/ASG Creation/Screenshot 2024-01-05 151251.png>)

5. Now We need a 'Target Group'<br>
  - Select 'Create a Target Group' from the dropdown box.<br>
  - Now give it a name<br>
  ![Target Group](<../ASG Screenshots/ASG Creation/Screenshot 2024-01-05 151441.png>)

6. Turn on 'Health Checks'<br>
  - Enable 'Elastic Load Balancing Health Checks'<br>
  - hit next.<br>
![Health Checks](<../ASG Screenshots/ASG Creation/Screenshot 2024-01-05 151637.png>)

7. Configure 'Group Size and Scaling'.<br>
  - Set the 'Desired' amount of VM's to 2.<br>
  ![Desired](<../ASG Screenshots/ASG Creation/Screenshot 2024-01-05 151738.png>)<br>
  - Set the 'Min' and 'Max' Capacity accordingly<br>
  - Check 'Target Tracking Scaling Policy'<br>
  - adjust CPU Target Value accordingly.<br>
  ![Target Tracking](<../ASG Screenshots/ASG Creation/Screenshot 2024-01-05 152059.png>)

8. Select Maintenance Policy.<br>
  - We prioritize 'Availability' here.<br>
  ![Availability](<../ASG Screenshots/ASG Creation/Screenshot 2024-01-05 152156.png>)

9. Choose Notifications<br>
  - Set up notification alerts.<br>
  ![Alerts](<../ASG Screenshots/ASG Creation/Screenshot 2024-01-05 152245.png>) 

10. Now Add Tags.<br>
  - We need to add tags so that our EC2 Instances Have a name when they are created.<br>
  ![Alt text](<../ASG Screenshots/ASG Creation/Screenshot 2024-01-05 152349.png>)
