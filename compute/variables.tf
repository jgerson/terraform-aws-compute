variable "prefix" {}

variable "env" {}

variable "owner" {}

variable "ttl" {
  default = 72
}

variable "ami_id" {
  default = "ami-0f3f3743e0ea68efd"
}

variable "instance_type" {
  default = "t2.nano"
}

variable "key_name" {}
