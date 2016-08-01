variable "region" {
  description = "Region specified by the root module"
  type = "string"
}

variable "root_dns_zone_id" {
  description = "Route53 ZoneID for the domain (spogliani.net)"
  type = "string"
}

provider "aws" {
  alias  = "private"
  region = "${var.region}"
}
