variable "allowed_cidr_blocks" {
  type = "list"
  description = "cidr blocks to allow access"
}

variable "ami" {
  type = "string"
}

variable "default_tags" {
  type = "map"
  default = {}
}

variable "dns_prefix" {
  type = "string"
}

variable "env" {
  default = "string"
}

variable "kafka_ebs_block_size" {
  default = "10"
}

variable "subnet_ids" {
  type = "map"
}

variable "kafka_lvm_ebs_mountpoints" {
  type = "list"
  default = ["/dev/sdf"]
}

variable "key_name" {
  type = "string"
}

variable "instance_type" {
  type = "string"
}

variable "resource_name_prefix" {
  type = "string"
}

variable "route_53_zone_id" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "additional_vpc_security_group_ids" {
  type = "list"
  default = []
}


variable "zookeeper_hosts" {
  type = "string"
}

variable "broker_listeners" {
  type = "map"
  default = {
    "PLAINTEXT" = "9092"
  }
}