terraform = {
  backend "s3" {
    bucket         = "terraform-devops-challenge-apps"
    key            = "network.tfstate"
    dynamodb_table = "TerraformState"
    region         = "us-east-1"
  }
}

output "vpc_id" {
  value = "${aws_vpc.default_vpc.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.default_vpc.cidr_block}"
}

output "rds_subnet_1_id" {
  value = "${aws_subnet.rds_subnet_1.id}"
}

output "rds_subnet_2_id" {
  value = "${aws_subnet.rds_subnet_2.id}"
}

provider "aws" {
  region = "us-east-1"
}

# Default VPC
resource "aws_vpc" "default_vpc" {
  cidr_block       = "${var.vpc_cidr_block}"

  tags = {
    Name = "devops-challenge-apps-vpc"
  }
}

# Private Subnets for RDS
resource "aws_subnet" "rds_subnet_1" {
  vpc_id     = "${aws_vpc.default_vpc.id}"
  cidr_block = "${var.rds_private_subnet_1_vpc_cidr_block}"

  tags = {
    Name = "devops-challenge-apps-rds-subnet-1"
  }
}

resource "aws_subnet" "rds_subnet_2" {
  vpc_id     = "${aws_vpc.default_vpc.id}"
  cidr_block = "${var.rds_private_subnet_2_vpc_cidr_block}"

  tags = {
    Name = "devops-challenge-apps-rds-subnet-2"
  }
}
