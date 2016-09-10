resource "aws_route53_zone" "dns-root" {
  provider = "aws.private"
  name = "trecamini.net"
}

resource "aws_route53_record" "root" {
  provider = "aws.private"

  zone_id = "${aws_route53_zone.dns-root.zone_id}"
  name = "trecamini.net"
  type = "A"

  alias {
    name = "${aws_s3_bucket.trecamini-net.website_domain}"
    zone_id = "${aws_s3_bucket.trecamini-net.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "root-www" {
  provider = "aws.private"

  zone_id = "${aws_route53_zone.dns-root.zone_id}"
  name = "www.trecamini.net"
  type = "A"

  alias {
    name = "${aws_s3_bucket.www-trecamini-net.website_domain}"
    zone_id = "${aws_s3_bucket.www-trecamini-net.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "dns-root-mx" {
  provider = "aws.private"

  zone_id = "${aws_route53_zone.dns-root.zone_id}"
  name = "trecamini.net"
  type = "MX"

  ttl  = "300"
  records = ["0 mail5.hostinguk.net"]
}


/*** Alias domains ***/
variable "domain-alias-bucket-count" {
  type = "string"
  default = "4"
}

variable "domain-alias-zone-count" {
  type = "string"
  default = "2"
}

variable "domain-alias-name" {
  type = "map"
  default = {
    "0" = "itrecamini.net"
    "1" = "trecamini.com"
    "2" = "www.itrecamini.net"
    "3" = "www.trecamini.com"
  }
}

resource "aws_route53_zone" "domain-alias-dns-root" {
  provider = "aws.private"
  count = "${var.domain-alias-zone-count}"
  name  = "${lookup(var.domain-alias-name, count.index)}"
}

resource "aws_s3_bucket" "domain-alias-bucket" {
  provider = "aws.private"
  count = "${var.domain-alias-bucket-count}"

  bucket = "${lookup(var.domain-alias-name, count.index)}"
  acl    = "public-read"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicReadGetObject",
    "Effect": "Allow",
    "Principal": {
      "AWS": "*"
    },
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::${lookup(var.domain-alias-name, count.index)}/*"
  }]
}
EOF

  website {
    redirect_all_requests_to = "www.trecamini.net"
  }
}

resource "aws_route53_record" "domain-alias-dns" {
  provider = "aws.private"
  count = "${var.domain-alias-zone-count}"

  zone_id = "${element(aws_route53_zone.domain-alias-dns-root.*.zone_id, count.index)}"
  name = "${lookup(var.domain-alias-name, count.index)}"
  type = "A"

  alias {
    name = "${element(aws_s3_bucket.domain-alias-bucket.*.website_domain, count.index)}"
    zone_id = "${element(aws_s3_bucket.domain-alias-bucket.*.hosted_zone_id, count.index)}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "domain-alias-dns-www" {
  provider = "aws.private"
  count = "${var.domain-alias-zone-count}"

  zone_id = "${element(aws_route53_zone.domain-alias-dns-root.*.zone_id, count.index + var.domain-alias-zone-count)}"
  name = "${lookup(var.domain-alias-name, count.index + var.domain-alias-zone-count)}"
  type = "A"

  alias {
    name = "${element(aws_s3_bucket.domain-alias-bucket.*.website_domain, count.index + var.domain-alias-zone-count)}"
    zone_id = "${element(aws_s3_bucket.domain-alias-bucket.*.hosted_zone_id, count.index + var.domain-alias-zone-count)}"
    evaluate_target_health = false
  }
}
