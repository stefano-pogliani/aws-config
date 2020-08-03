# A perstonal AWS
This repository contains files, scripts, and others used
to configure my personal AWS account.


## Root and main user
Start by creating an AWS account and secure the root user.
After the registration process is complete create a billing alarm!

Next create a new user and the `admin` group.
Attach the policy to the admin group (`AllowUsedServicesOnly`)
found in `iam/admin.json`


## Secrets
Terraform stores secrets into the state file.
Building HTTPS sites means having certificate files around.
All these secrets are kept in the `secrets/` directory which is
not published as part of the repository.
