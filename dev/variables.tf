variable "resource_name_prefix" {
  default = "tlm-kafka-aws"
}

variable "docker_ami" {
  default = "ami-02fd0b06f06d93dfc"
}

variable "default_tags" {
  type = "map"

  default = {
    "team"            = "tlm"
  }
}

variable "key_name" {
  default = "personal-aws-thoughtworks-key"
}

variable "vpc_cidr" {
  default = "0.0.0.0/0"
}

variable "dns_zoneid" {
  default = "Z2O73FYENC8AWT"
}


variable "project_name" {
  default = "tlm"
}

variable "kafka_hosts_string" {
  default = "a01.kafka.tlm.tlm-kafka-aws:9092"
}

variable "instance_type" {
  type = "map"

  default = {
    kafka          = "t2.micro"
    zookeeper      = "t2.micro"
  }
}

# application subnets
variable "subnet_ids" {
  type = "map"

  default = {
    ap-southeast-2a = "subnet-406b6627"
    ap-southeast-2b = "subnet-a692adef"
    ap-southeast-2c = "subnet-c27ac69a"
  }
}

variable "vpc_id" {
  default = "vpc-9e4b6ef9"
}

variable "zookeeper_hosts_string" {
  default = "a01.zookeeper.tlm.tlm-kafka-aws:2181"
}

variable "zookeeper_hosts" {
  default = ["a01.zookeeper.tlm.tlm-kafka-aws"]
}

variable "broker_listeners" {
  type = "map"
  default = {
    "PLAINTEXT" = "9092"
  }
}

variable "kafka_ebs_block_size" {
  default = "10"
}