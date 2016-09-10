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
  records = ["0 mail5.hostinguk.net"]
}


/*** DKIM settings. ***/
variable "dkim-cname-count" {
  type = "string"
  default = "3"
}

variable "dkim-cname-name" {
  type = "map"
  default = {
    "0" = "7ix4pdo6pudpj2lgzmseyuld7md456eu._domainkey.spogliani.net"
    "1" = "5wk4bei6m7sqohknxypo5bos7czlhzms._domainkey.spogliani.net"
    "2" = "eptpfsbm6w6xiaa33qedvu3i4xs6rsqb._domainkey.spogliani.net"
  }
}

variable "dkim-cname-value" {
  type = "map"
  default = {
    "0" = "7ix4pdo6pudpj2lgzmseyuld7md456eu.dkim.amazonses.com"
    "1" = "5wk4bei6m7sqohknxypo5bos7czlhzms.dkim.amazonses.com"
    "2" = "eptpfsbm6w6xiaa33qedvu3i4xs6rsqb.dkim.amazonses.com"
  }
}

variable "dkim-txt-count" {
  type = "string"
  default = "2"
}

variable "dkim-txt-name" {
  type = "map"
  default = {
    "0" = "_amazonses.spogliani.net"
    "1" = "spogliani2016._domainKey.spogliani.net"
  }
}

variable "dkim-txt-value" {
  type = "map"
  default = {
    "0" = "urayRj0bKaRTFSZUlIjgVB8k7rtWHw57VbCvsfOFImU="
    "1" = "p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCvwSenH9+xnED28bUyMrIOmGPpseS2KoXH+3It7GceKz5D7+PoEihfIwQkDvEmiqU8NBWjl0v8wtxMz12ZenkMt7IgZHAYhIx6zrnYEhtP6ii/LBBhAFAGz6xxlokyWFSHdepn2O5N+NwtmhLxf8eQK0Jq9IUEqROGZZ91hXhe8QIDAQAB"
  }
}

resource "aws_route53_record" "dns-dkim-cnames" {
  provider = "aws.private"
  count = "${var.dkim-cname-count}"

  zone_id = "${aws_route53_zone.dns-root.zone_id}"
  type = "CNAME"
  ttl  = "300"

  name = "${lookup(var.dkim-cname-name, count.index)}"
  records = ["${lookup(var.dkim-cname-value, count.index)}"]
}

resource "aws_route53_record" "dns-dkim-txts" {
  provider = "aws.private"
  count = "${var.dkim-txt-count}"

  zone_id = "${aws_route53_zone.dns-root.zone_id}"
  type = "TXT"
  ttl  = "300"

  name = "${lookup(var.dkim-txt-name, count.index)}"
  records = ["${lookup(var.dkim-txt-value, count.index)}"]
}
