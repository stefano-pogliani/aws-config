A perstonal AWS
===============
This repository contains files, scripts, and others used
to configure my personal AWS account.


Root and main user
------------------
Start by creating an AWS account and secure the root user.
After the registration process is complete create a billing alarm!

Next create a new user and the `admin` group.
Attach the policy to the admin group (`AllowUsedServicesOnly`)
found in `iam/admin.json`


Create AWS CLI profile
----------------------
```bash
$> aws --profile=flaviopogliani-net configure
AWS Access Key ID [None]: *****
AWS Secret Access Key [None]: ******
Default region name [None]: eu-west-1
Default output format [None]: json
```


Secrets
-------
Terraform stores secrets into the state file.
Building HTTPS sites means having certificate files around.
All these secrets are kept in the `secrets/` directory which is
not published as part of the repository.


Migrations
----------
This section is a list of migrations from one tool to another
or a provider to anouther.
They are left here for record.

### 2. Migrating to CloudFormation
While Terraform is nice for cross-cloud,
CloudFormation is simpler and more powerful for AWS only setups.

Migrate from Terraform to CloudFormation!

Websites:

  1. Rebuild all websites with CloudFormation
    * Create Origin Bucket
    * Create CloudFront distro
    * Update DNS names manually
  2. Delete old buckets.
  3. Delete old terraform files.

Everything else to be decided:

  * DNS zones: create comented out template but don't rebuild.
  * DNS record: gradually add in small groups to CF and remove exiting before stack update.

### 1. Migrating domains
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
