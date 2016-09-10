resource "aws_route53_zone" "dns-root" {
  provider = "aws.private"
  name = "flaviopogliani.net"
}

resource "aws_route53_record" "root" {
  provider = "aws.private"

  zone_id = "${aws_route53_zone.dns-root.zone_id}"
  name = "flaviopogliani.net"
  type = "A"

  alias {
    name = "${aws_s3_bucket.flaviopogliani-net.website_domain}"
    zone_id = "${aws_s3_bucket.flaviopogliani-net.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "root-www" {
  provider = "aws.private"

  zone_id = "${aws_route53_zone.dns-root.zone_id}"
  name = "www.flaviopogliani.net"
  type = "A"

  alias {
    name = "${aws_s3_bucket.www-flaviopogliani-net.website_domain}"
    zone_id = "${aws_s3_bucket.www-flaviopogliani-net.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "dns-root-mx" {
  provider = "aws.private"

  zone_id = "${aws_route53_zone.dns-root.zone_id}"
  name = "flaviopogliani.net"
  type = "MX"

  ttl  = "300"
  records = ["0 mail5.hostinguk.net"]
}
