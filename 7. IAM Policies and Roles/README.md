# What is an IAM Role?

Rather than storing AWS credentials on an EC2 instance, AWS recommends using an **IAM role**. When an IAM role is created for EC2, AWS automatically creates an **instance profile** with the same name. This instance profile is what gets attached to the EC2 instance.

# What is a Policy?

AWS Policies define permissions that are attached to the role. All new roles have no permissions by default. Therefore, we only add permissions to the policy that we need our instance to have. This follows AWS Least privileged policy.

# How To Create a Policy and Role.

- [Creating an IAM Role and Policy](<../7. IAM Policies and Roles\Creating IAM Policies and Roles\README.md>)

