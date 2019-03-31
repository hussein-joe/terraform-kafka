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

variable "key_name" {
  type = "string"
}

variable "instance_type" {
  type = "string"
}

variable "resource_name_prefix" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "additional_vpc_security_group_ids" {
  type = "list"
  default = []
}

variable "zookeeper_cluster_hosts" {
  type = "list"
}

variable "schedule_name" {
  type = "string"
}
variable "subnet_ids" {
  type = "map"
}

variable "env" {
  type = "string"
}