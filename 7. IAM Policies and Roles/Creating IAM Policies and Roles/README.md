- [Creating an IAM Policy, IAM Role and Attaching an Instance Profile to an EC2 Instance](#creating-an-iam-policy-iam-role-and-attaching-an-instance-profile-to-an-ec2-instance)
  - [Overview](#overview)
  - [Prerequisites](#prerequisites)
- [Step 1 - Create the IAM Policy](#step-1---create-the-iam-policy)
- [Step 2 - Create the IAM Role](#step-2---create-the-iam-role)
    - [Trusted Entity](#trusted-entity)
    - [Permissions](#permissions)
    - [Role Details](#role-details)
  - [Instance Profile](#instance-profile)
- [Step 3 - Attach the Instance Profile to an Existing EC2 Instance](#step-3---attach-the-instance-profile-to-an-existing-ec2-instance)
- [Step 4 - Attach the Instance Profile When Launching a New EC2 Instance](#step-4---attach-the-instance-profile-when-launching-a-new-ec2-instance)
- [Verifying the Role](#verifying-the-role)
  - [Testing S3 Access](#testing-s3-access)
- [Security Best Practices](#security-best-practices)
- [Troubleshooting](#troubleshooting)
  - [Access Denied](#access-denied)
  - [No Credentials Found](#no-credentials-found)
  - [Unable to Download from S3](#unable-to-download-from-s3)
- [Summary](#summary)



# Creating an IAM Policy, IAM Role and Attaching an Instance Profile to an EC2 Instance

This guide explains how to create a least-privilege IAM policy that allows an EC2 instance to download an application JAR from Amazon S3, create an IAM role, and attach the resulting instance profile to an existing EC2 instance.

---

## Overview

Rather than storing AWS credentials on an EC2 instance, AWS recommends using an **IAM role**. When an IAM role is created for EC2, AWS automatically creates an **instance profile** with the same name. This instance profile is what gets attached to the EC2 instance.

In this example, the EC2 instance will have read-only access to a single S3 bucket containing the application JAR.

---

## Prerequisites

Before starting, ensure you have:

- An AWS account with IAM permissions.
- An existing private S3 bucket.
- The application JAR uploaded to the bucket.
- The bucket name available.

Example bucket:

```text
fishing-app-deploy-123456789012
```

---

# Step 1 - Create the IAM Policy

1. Open the **AWS Management Console**.
2. Navigate to **IAM**.
3. Select **Policies**.
4. Click **Create policy**.
5. Select the **JSON** tab.
6. Replace the default policy with the following:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "S3GetObject",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": "arn:aws:s3:::your-bucket-name/*"
    },
    {
      "Sid": "S3ListBucket",
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket"
      ],
      "Resource": "arn:aws:s3:::your-bucket-name"
    }
  ]
}
```

> Replace **your-bucket-name** with your actual S3 bucket name.

7. Click **Next**.
8. Enter the following details:

| Setting | Value |
|---------|-------|
| Policy Name | `EC2-S3-ReadOnly` |
| Description | Read-only access to specified buckets |

9. Click **Create policy**.

---

# Step 2 - Create the IAM Role

1. Navigate to **IAM**.
2. Select **Roles**.
3. Click **Create role**.

### Trusted Entity

Configure the following:

| Setting | Value |
|---------|-------|
| Trusted entity type | AWS service |
| Use case | EC2 |

Click **Next**.

---

### Permissions

1. Search for the policy created earlier:

```text
EC2-S3-ReadOnly
```

2. Select the policy.
3. Click **Next**.

---

### Role Details

Configure the following:

| Setting | Value |
|---------|-------|
| Role name | `EC2-S3-Role` |
| Description | Allows EC2 instances to read Objects from S3 buckets |

Click **Create role**.

---

## Instance Profile

When the role is created using the **EC2** trusted entity, AWS automatically creates an **instance profile** with the same name.

No additional configuration is required.

For example:

| IAM Role | Instance Profile |
|----------|------------------|
| `EC2-S3-Role` | `EC2-S3-Role` |

The instance profile is what gets attached to an EC2 instance.

---

# Step 3 - Attach the Instance Profile to an Existing EC2 Instance

If your EC2 instance is already running, you can attach the instance profile without recreating the instance.

1. Open the **EC2 Console**.
2. Select **Instances**.
3. Select your EC2 instance.
4. Choose:

```text
Actions
    → Security
        → Modify IAM role
```

5. Under **IAM Role**, select:

```text
EC2-S3-Role
```

6. Click **Update IAM role**.

The instance will now automatically receive temporary AWS credentials through the instance metadata service.

No reboot is required.

---


# Step 4 - Attach the Instance Profile When Launching a New EC2 Instance

If you are launching a new EC2 instance, you can attach the instance profile during the launch process. This is the recommended approach, as the instance will have the required permissions immediately after it starts.

1. Open the **EC2 Console**.
2. Click **Launch instances**.
3. Configure the instance as required (AMI, instance type, key pair, networking, storage, etc.).
4. Expand the **Advanced details** section.
5. Scroll to **IAM instance profile**.
6. Select:

```text
EC2-S3-Role
```

7. Continue configuring the remaining launch options.
8. Click **Launch instance**.

Once the instance starts, AWS automatically provides temporary credentials to the instance through the Instance Metadata Service (IMDS). Any application or AWS CLI commands running on the instance can use these credentials without requiring access keys.

> **Note:** The **IAM instance profile** is what is attached to the EC2 instance. Because AWS automatically creates an instance profile with the same name as the IAM role, you'll simply select the role name from the drop-down list.

---

# Verifying the Role

SSH onto the EC2 instance and run:

```bash
aws sts get-caller-identity
```

You should receive output similar to:

```json
{
    "UserId": "...",
    "Account": "123456789012",
    "Arn": "arn:aws:sts::123456789012:assumed-role/EC2-S3-Role/i-0123456789abcdef0"
}
```

---

## Testing S3 Access

List the bucket contents:

```bash
aws s3 ls s3://your-bucket-name/
```

Download the application:

```bash
aws s3 cp s3://your-bucket-name/path/filename
```

If both commands succeed, the IAM role has been configured correctly.

---

# Security Best Practices

- Follow the principle of least privilege.
- Grant access only to the required S3 bucket.
- Keep the S3 bucket private.
- Never store AWS access keys on EC2 instances.
- Use IAM roles instead of long-lived credentials.
- Rotate permissions periodically and review IAM policies.

---

# Troubleshooting

## Access Denied

Check that:

- The IAM role is attached to the EC2 instance.
- The bucket name in the IAM policy is correct.
- The object path exists.
- The policy includes both:
  - `s3:GetObject`
  - `s3:ListBucket`

---

## No Credentials Found

Run:

```bash
aws sts get-caller-identity
```

If credentials cannot be found:

- Verify the IAM role is attached.
- Wait a few minutes after attaching the role.
- Ensure the EC2 instance can reach the Instance Metadata Service (IMDS).

---

## Unable to Download from S3

Verify:

- The bucket exists.
- The object key is correct.
- The instance has internet connectivity or an S3 VPC Endpoint.
- The bucket policy does not explicitly deny access.

---

# Summary

The completed configuration provides:

- A private S3 bucket.
- A least-privilege IAM policy.
- An EC2 IAM role.
- An automatically created instance profile.
- Temporary AWS credentials delivered securely to the EC2 instance.
- Secure access to download application artifacts without storing AWS credentials on the server.