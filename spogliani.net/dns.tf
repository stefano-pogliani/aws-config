resource "aws_route53_zone" "dns-root" {
  provider = "aws.private"
  name = "spogliani.net"
}

resource "aws_route53_record" "dns-root-mx" {
  provider = "aws.private"

  zone_id = "${aws_route53_zone.dns-root.zone_id}"
  name = "spogliani.net"
  type = "MX"

  ttl  = "300"
  records = ["0 212.1.215.8"]
}
