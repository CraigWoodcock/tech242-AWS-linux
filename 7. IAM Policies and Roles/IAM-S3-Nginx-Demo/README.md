- [Deploying a Static Website from Amazon S3 to an EC2 Instance Using an IAM Role](#deploying-a-static-website-from-amazon-s3-to-an-ec2-instance-using-an-iam-role)
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Step 1 - Create an S3 Bucket](#step-1---create-an-s3-bucket)
- [Step 2 - Create the Website Folder](#step-2---create-the-website-folder)
- [Step 3 - Upload the Website](#step-3---upload-the-website)
- [Step 4 - Create the User Data Script](#step-4---create-the-user-data-script)
- [Step 5 - Launch an EC2 Instance](#step-5---launch-an-ec2-instance)
  - [Attach the IAM Instance Profile](#attach-the-iam-instance-profile)
  - [Configure User Data](#configure-user-data)
- [Step 6 - Verify the Website](#step-6---verify-the-website)
- [Step 7 - Verify the IAM Role](#step-7---verify-the-iam-role)
- [Step 9 - Replace the Image](#step-9---replace-the-image)
- [Step 10 - Restore the Original Image](#step-10---restore-the-original-image)
- [Troubleshooting](#troubleshooting)
  - [Website Doesn't Load](#website-doesnt-load)
  - [User Data Didn't Execute](#user-data-didnt-execute)
  - [Access Denied](#access-denied)
  - [Verify Website Files](#verify-website-files)
  - [Test S3 Access](#test-s3-access)
- [Summary](#summary)


# Deploying a Static Website from Amazon S3 to an EC2 Instance Using an IAM Role

This guide demonstrates how to securely deploy a static website from a private Amazon S3 bucket to an EC2 instance using an IAM Role and User Data.

By the end of this guide you will have:

- Created a private S3 bucket.
- Uploaded a simple website.
- Created a User Data script that automatically installs Nginx and downloads the website from S3.
- Launched an EC2 instance using the IAM Role created previously.
- Verified the website is being served by Nginx.
- Updated the website directly from S3 to demonstrate the IAM Role is working correctly.

---

# Overview

The website will remain private inside Amazon S3.

The EC2 instance will use its attached IAM Role to securely download the website during startup.

No AWS Access Keys or Secret Keys are stored on the server.

The architecture looks like this:

```text
               Internet
                    │
                    │
          ┌───────────────────┐
          │     EC2 Instance  │
          │      Ubuntu       │
          │       Nginx       │
          └─────────┬─────────┘
                    │
        IAM Instance Profile
                    │
                    ▼
        ┌────────────────────┐
        │   Private S3 Bucket│
        │     website/       │
        └────────────────────┘
```

---

# Prerequisites

Before starting you should have:

- An AWS Account.
- An IAM Role with S3 read permissions.
- A Security Group allowing:
  - SSH (22)
  - HTTP (80)
- An EC2 Key Pair.

This guide assumes you have already completed the IAM Role guide.

---

# Step 1 - Create an S3 Bucket

1. Open the **AWS Console**.
2. Navigate to **S3**.
3. Click **Create bucket**.

Configure:

| Setting | Value |
|---------|-------|
| Bucket Name | `my-static-website-bucket-12345` |
| Region | Same region as EC2 |
| Object Ownership | ACLs Disabled |
| Block Public Access | Enabled (All four boxes checked) |
| Versioning | Optional |
| Encryption | SSE-S3 |

Click **Create Bucket**.

---

# Step 2 - Create the Website Folder

Open the bucket.

Create a folder named:

```text
website
```

The bucket should now look like:

```text
website/
```

---

# Step 3 - Upload the Website

Upload the contents of the website folder in this directory.

The bucket should contain:

```text
website/

    index.html

    image1.jpg

    image2.jpg
```

---

# Step 4 - Create the User Data Script

Create the following script.

```bash
#!/bin/bash

set -e

echo "Updating package lists..."
apt update -y

echo "Upgrading packages..."
DEBIAN_FRONTEND=noninteractive apt upgrade -y

echo "Installing Nginx..."
apt install nginx -y

echo "Installing AWS CLI..."
apt install awscli -y

echo "Removing default website..."
rm -rf /var/www/html/*

echo "Downloading website from S3..."

aws s3 cp s3://my-static-website-bucket-12345/website/ /var/www/html/ --recursive

systemctl enable nginx

systemctl restart nginx

echo "Deployment Complete"
```

Replace:

```text
my-static-website-bucket-12345
```

with your own bucket name.

---

# Step 5 - Launch an EC2 Instance

Launch a new Ubuntu EC2 instance.

Configure:

| Setting | Value |
|---------|-------|
| AMI | Ubuntu Server |
| Instance Type | t3.micro |
| Security Group | HTTP (80), SSH (22) |
| Key Pair | Your existing key pair |

---

## Attach the IAM Instance Profile

Expand **Advanced Details**.

Locate:

```text
IAM Instance Profile
```

Select:

```text
EC2-IAM-S3-Role
```

---

## Configure User Data

Paste the User Data script created earlier into the **User Data** box.

Launch the instance.

Wait approximately two minutes.

---

# Step 6 - Verify the Website

Open a browser.

Navigate to:

```text
http://<EC2-Public-IP>
```

You should see:

- The heading.
- The description.
- Image 1.

---

# Step 7 - Verify the IAM Role

SSH into the instance.

Run:

```bash
aws sts get-caller-identity
```

You should receive output similar to:

```json
{
  "Arn":"arn:aws:sts::123456789012:assumed-role/EC2-IAM-S3-Role/..."
}
```

---

# Step 9 - Replace the Image

Copy the second image from S3.

```bash
sudo aws s3 cp \
s3://my-static-website-bucket-12345/website/image2.jpg \
/var/www/html/image1.jpg
```

Refresh the browser.

The image should now change.

This proves the EC2 instance can securely download files from S3 using the IAM Role.

---

# Step 10 - Restore the Original Image

Restore the original image.

```bash
sudo aws s3 cp \
s3://my-static-website-bucket-12345/website/image1.jpg \
/var/www/html/image1.jpg
```

Refresh the browser.

The original image should return.

---

# Troubleshooting

## Website Doesn't Load

Check Nginx:

```bash
sudo systemctl status nginx
```

---

## User Data Didn't Execute

View the cloud-init logs:

```bash
sudo cat /var/log/cloud-init-output.log
```

---

## Access Denied

Verify:

- The IAM Role is attached.
- The bucket name is correct.
- The IAM Policy contains:
  - `s3:GetObject`
  - `s3:ListBucket`

---

## Verify Website Files

List the web directory:

```bash
ls -la /var/www/html
```

Expected output:

```text
index.html

image1.jpg

image2.jpg
```

---

## Test S3 Access

List the bucket.

```bash
aws s3 ls s3://my-static-website-bucket-12345/website/
```

---

# Summary

You have successfully:

- Created a private S3 bucket.
- Uploaded a static website.
- Used an IAM Role to securely access S3.
- Installed Nginx automatically using User Data.
- Downloaded website files during instance startup.
- Verified the IAM Role using the AWS CLI.
- Updated website content directly from S3 without storing AWS credentials on the EC2 instance.

This same deployment pattern can be used to deploy Spring Boot applications, configuration files, scripts, or other application assets securely from Amazon S3.