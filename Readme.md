A perstonal AWS
===============
This repository contains files, scripts, and others used
to configure my personal AWS account.


Root and main user
------------------
Start by creating an AWS account and secure the root user.
After the registration process is complete create a billing alarm!

Next create a new user and the `admin` group.
Attach the following policy to the admin group (`AllowUsedServicesOnly`):
```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "AllowRoute53",
    "Effect": "Allow",
    "Action": ["route53:*"],
    "Resource": ["*"]
  }, {
    "Sid": "AllowRoute53Domains",
    "Effect": "Allow",
    "Action": ["route53domains:*"],
    "Resource": ["*"]
  }, {
    "Sid": "AllowBilling",
    "Effect": "Allow",
    "Action": ["aws-portal:*"],
    "Resource": ["*"]
  }, {
    "Sid": "AllowS3",
    "Effect": "Allow",
    "Action": ["s3:*"],
    "Resource": ["*"]
  }, {
    "Sid": "AllowSes",
    "Effect": "Allow",
    "Action": ["ses:*"],
    "Resource": ["*"]
  }, {
    "Sid": "AllowCloudFront",
    "Effect": "Allow",
    "Action": ["cloudfront:*"],
    "Resource": ["*"]
  }, {
    "Sid": "AllowIAM",
    "Effect": "Allow",
    "Action": ["iam:*"],
    "Resource": ["*"]
  }]
}
```
