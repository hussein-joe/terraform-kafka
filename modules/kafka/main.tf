
resource "aws_security_group" "kafka_plaintext" {
  name_prefix = "${replace(var.resource_name_prefix, "_", "-")}-kafka-plaintext-security-group"
  description = "Allow Kafka plaintext access within the VPC"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 9092
    to_port = 9092
    protocol = "tcp"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = "${merge(var.default_tags, map(
    "Name", "${replace(var.resource_name_prefix, "_", "-")}-kafka-plaintext-security-group"
  ))}"
}



resource "template_file" "kafka_a01_userdata" {
  lifecycle { create_before_destroy = true }

  template = "${file("${path.module}/user-data.sh")}"

  vars {
    env = "${var.env}"
    dns_prefix = "${var.dns_prefix}"
    route_53_zone_id = "${var.route_53_zone_id}"
    zookeeper_hosts = "${var.zookeeper_hosts}"
    broker_listeners_protocols = "${join(",", keys(var.broker_listeners))}"
    broker_listeners_ports = "${join(",", values(var.broker_listeners))}"
  }
}

resource "aws_instance" "kafka_a01" {
  ami = "${var.ami}"
  associate_public_ip_address = true
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  subnet_id = "${var.subnet_ids["ap-southeast-2a"]}"
  tags = "${merge(var.default_tags, map(
    "Name", "${replace(var.resource_name_prefix, "_", "-")}-kafka-a01"
  ))}"
  user_data = "${template_file.kafka_a01_userdata.rendered}"
  security_groups = ["${concat(var.additional_vpc_security_group_ids)}"]
}