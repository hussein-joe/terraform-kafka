variable "default_tags" {
  type = "map"
  default = {}
  description = "default tags to merge in to all resources"
}

variable "resource_name_prefix" {
  type = "string"
  description = "A prefix to use for resource names"
}

variable "vpc_id" {
  type = "string"
}

