variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "rds_private_subnet_1_vpc_cidr_block" {
  default = "10.0.4.0/24"
}

variable "rds_private_subnet_2_vpc_cidr_block" {
  default = "10.0.5.0/24"
}
