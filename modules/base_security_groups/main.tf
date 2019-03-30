resource "aws_security_group" "ssh" {
  name_prefix = "${replace(var.resource_name_prefix, "_", "-")}-ssh-security-group"
  description = "Allow ssh access"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = "${merge(var.default_tags, map(
    "Name", "${replace(var.resource_name_prefix, "_", "-")}-ssh-security-group"
  ))}"
}

resource "aws_security_group" "allow_outbound" {
  name_prefix = "${replace(var.resource_name_prefix, "_", "-")}-outbound-security-group"
  description = "Allow outbound traffic"
  vpc_id = "${var.vpc_id}"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = "${merge(var.default_tags, map(
    "Name", "${replace(var.resource_name_prefix, "_", "-")}-outbound-security-group"
  ))}"
}
