# AWS Monitoring

## What is AWS Monitoring

- Reacting - Reacting to an issue without first thinking about
- Responding - Assessing the situation and taking action before an issue arises

Monitoring is a way for us to be able to monitor metrics of our services and applications to ensure that the system doesn't 'fall over' or fail.<br>

## Monitoring Levels

- Diagram to illustrate monitoring levels
![Alt text](<../Monitoring Screenshots/monitoring levels.png>)


1. No Monitoring - The 'App VM' in the diagram above has no monitoring system in place. When the CPU Load becomes too high, the 'App VM' will fail because there is no disaster recovery in place.

2. CloudWatch Dashboard - The 'App VM' has CloudWatch Monitoring in place via a dashboard. The dashboard is monitored by a human. This could lead to missed issues and the 'App VM' could still eventually fail.

3. CloudWatch Alert Managememnt System - 



## How Can we Monitor Our Applications on AWS?
We can monitor our applications or services on AWS using an Alert Management System called Cloud Watch. We can create a dashboard specific to each VM and enable detailed monitoring to visually see the load on our systems and take steps to respond to issues.

We can also configure Cloud Watch alerts to notify us when metrics hit a specific point so that we can respond accordingly.

- Monitoring Tab inside Instance Details:
   - Select 'Manage Detailed Monitoring'
  ![Monitoring Tab](<../Monitoring Screenshots/Screenshot 2024-01-05 124939.png>)

- Detailed Monitoring Pop-Up
    - Select 'enable' and 'Confirm'<br>
    - we can also uncheck the 'enable' box and 'Confirm' to disable
  ![Monitoring pop-up](<../Monitoring Screenshots/Screenshot 2024-01-05 125015.png>)

- Add to Dashboard Pop-UP
   - Select Dashboard or Create a New One:<br> 
  ![Dashboard Pop-up](<../Monitoring Screenshots/Screenshot 2024-01-05 125047.png>)

- Custom CloudWatch Dashboard 
  ![Dashboard](<../Monitoring Screenshots/Dashboard.png>)

- CPU Utilization Chart 
  ![CPU Chart](<../Monitoring Screenshots/cpu utilization.png>)


