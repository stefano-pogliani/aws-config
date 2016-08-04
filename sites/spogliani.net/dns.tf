resource "aws_route53_record" "root" {
  provider = "aws.private"

  zone_id = "${var.root_dns_zone_id}"
  name = "spogliani.net"
  type = "A"

  alias {
    name = "${aws_s3_bucket.spogliani-net.website_domain}"
    zone_id = "${aws_s3_bucket.spogliani-net.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "root-www" {
  provider = "aws.private"

  zone_id = "${var.root_dns_zone_id}"
  name = "www.spogliani.net"
  type = "A"

  alias {
    name = "${aws_s3_bucket.www-spogliani-net.website_domain}"
    zone_id = "${aws_s3_bucket.www-spogliani-net.hosted_zone_id}"
    evaluate_target_health = false
  }
}
