- [IAM Policies, Roles and Instance Profiles](#iam-policies-roles-and-instance-profiles)
  - [What is an IAM Role?](#what-is-an-iam-role)
  - [What is a Policy?](#what-is-a-policy)
  - [How To Create a Policy, Role and attach the Instance Profile.](#how-to-create-a-policy-role-and-attach-the-instance-profile)
  - [Iam - S3 - Nginx website Demonstrating S3 Access via Instance Profile.](#iam---s3---nginx-website-demonstrating-s3-access-via-instance-profile)



# IAM Policies, Roles and Instance Profiles

## What is an IAM Role?

Rather than storing AWS credentials on an EC2 instance, AWS recommends using an **IAM role**. When an IAM role is created for EC2, AWS automatically creates an **instance profile** with the same name. This instance profile is what gets attached to the EC2 instance.

## What is a Policy?

AWS Policies define permissions that are attached to the role. All new roles have no permissions by default. Therefore, we only add permissions to the policy that we need our instance to have. This follows AWS Least privileged policy.

## How To Create a Policy, Role and attach the Instance Profile.

- [Creating an IAM Role and Policy](<Creating IAM Policies and Roles\README.md>)

## Iam - S3 - Nginx website Demonstrating S3 Access via Instance Profile.

- [IAM-S3-Nginx-Demo](<IAM-S3-Nginx-Demo\README.md>)
