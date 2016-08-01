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


Secrets
-------
Terraform stores secrets into the state file.
Building HTTPS sites means having certificate files around.
All these secrets are kept in the `secrets/` directory which is
not published as part of the repository.


Migrating domains
-----------------
Migrating domains to AWS (as with any DNS migration) comes with
a high risk of downtime and/or inconsistencies.
This is because, while the DNS update propagates, the same name
points to two resources.

The following steps should minimise downtime:

  1. Create Route53 hosted zone.
  2. Configure it to point to S3 bucket serving the site.
  3. Register with your preferred email hosting solution.
  4. Configure MX record as documented by email hosting service.
  5. Create all needed inboxes.
  6. Update domain's NS and wait 48 hours (world wide propagation).
  7. Migrate email from old server to new.
  8. Transfer the domain.
