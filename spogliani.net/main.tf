variable "region" {
  description = "Region specified by the root module"
  type = "string"
}

provider "aws" {
  alias  = "private"
  region = "${var.region}"
}

output "zone_id" {
  value = "${aws_route53_zone.dns-root.zone_id}"
}
