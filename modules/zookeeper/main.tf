resource "aws_security_group" "zookeeper" {
  description = "Allow Zookeeper access within the VPC"
  name_prefix = "${replace(var.resource_name_prefix, "_", "-")}-zookeeper-security-group"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 2181
    to_port = 2181
    protocol = "tcp"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }

  ingress {
    from_port = 2888
    to_port = 2888
    protocol = "tcp"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }

  ingress {
    from_port = 3888
    to_port = 3888
    protocol = "tcp"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = "${merge(var.default_tags, map(
    "Name", "${replace(var.resource_name_prefix, "_", "-")}-zookeeper-security-group"
  ))}"
}

# -----------------------------------------------------------------

data "template_file" "zookeeper_a01_userdata" {
  template = "${file("${path.module}/user-data.sh")}"
  vars {
    id = "1"
    zookeeper_cluster_hosts = "${join(" ",var.zookeeper_cluster_hosts)}"
    env = "${var.env}"
  }
}

resource "aws_instance" "zookeeper_a01" {
  ami = "${var.ami}"
  associate_public_ip_address = true
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  subnet_id = "${var.subnet_ids["ap-southeast-2a"]}"
  tags = "${merge(var.default_tags, map(
    "Name", "${replace(var.resource_name_prefix, "_", "-")}-zookeeper-a01"
  ))}"
  user_data = "${data.template_file.zookeeper_a01_userdata.rendered}"
  vpc_security_group_ids = ["${concat(var.additional_vpc_security_group_ids, list("${aws_security_group.zookeeper.id}"))}"]
}
