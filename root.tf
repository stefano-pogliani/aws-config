module "spogliani-net" {
  source = "./spogliani.net"
  region = "eu-west-1"
}

module "sites-spogliani-net" {
  source = "./sites/spogliani.net"
  region = "eu-west-1"
  root_dns_zone_id = "${module.spogliani-net.zone_id}"
}
