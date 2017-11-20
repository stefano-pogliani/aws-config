SES Configuration
=================
SES is not available in the Frankfurt region so I've used the Ireland one.
It is used by my home server to send emails.

I am still in the sandbox and I do not plan to get out of it any time soon:

  * Domains are verified manually adding records to Route53 using CloudFormation.
  * Emails are verified manually so they can receive emails from SES.
  * Users are created manually and credentials stored in ansible vaults.
