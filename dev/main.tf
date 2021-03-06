terraform {}

provider "aws" {
  region = "ap-southeast-2"
}


module "base_security_groups" {
  default_tags = "${var.default_tags}"
  resource_name_prefix = "${var.resource_name_prefix}"
  source = "../modules/base_security_groups"
  vpc_id = "${var.vpc_id}"
}

module "zookeeper" {
  additional_vpc_security_group_ids = ["${module.base_security_groups.allow_ssh}",  "${module.base_security_groups.allow_outbound}"]
  allowed_cidr_blocks               = ["${var.vpc_cidr}"]
  default_tags                      = "${var.default_tags}"
  instance_type                     = "${var.instance_type["zookeeper"]}"
  ami = "${var.docker_ami}"
  key_name                          = "${var.key_name}"
  resource_name_prefix              = "${var.resource_name_prefix}"
  schedule_name                     = "24x7"
  source                            = "../modules/zookeeper"
  subnet_ids                        = "${var.subnet_ids}"
  vpc_id                            = "${var.vpc_id}"
  zookeeper_cluster_hosts           = "${var.zookeeper_hosts}"
  env                               = "dev"
}


module "kafka" {
  additional_vpc_security_group_ids = [ "${module.base_security_groups.allow_ssh}", "${module.base_security_groups.allow_outbound}", "${module.kafka.kafka_plaintext_security_group}" ]
  allowed_cidr_blocks = ["${var.vpc_cidr}"]
  ami = "${var.docker_ami}"
  default_tags = "${var.default_tags}"
  env = "dev"
  dns_prefix = "kafka.${var.project_name}.dev"
  route_53_zone_id = "${var.dns_zoneid}"
  instance_type = "${var.instance_type["kafka"]}"
  key_name = "${var.key_name}"
  resource_name_prefix = "${var.resource_name_prefix}"
  source = "../modules/kafka"
  subnet_ids = "${var.subnet_ids}"
  vpc_id = "${var.vpc_id}"
  zookeeper_hosts = "${module.zookeeper.zookeeper_a01_dns}:2181"
  broker_listeners = "${var.broker_listeners}"
  kafka_ebs_block_size = "${var.kafka_ebs_block_size}"
}



/*
resource "aws_route53_record" "kafka_a01" {
  name = "kafka-a01.${var.project_name}.dev"
  records = ["${module.kafka.kafka_a01_ip}"]
  ttl = "300"
  type = "A"
  zone_id = "${var.dns_zoneid}"
}
*/
