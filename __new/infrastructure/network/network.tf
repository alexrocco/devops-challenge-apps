terraform = {
  backend "s3" {
    bucket         = "terraform-devops-challenge-apps"
    key            = "network.tfstate"
    dynamodb_table = "TerraformState"
    region         = "us-east-1"
  }
}

output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.default.cidr_block}"
}

provider "aws" {
  region = "us-east-1"
}

# Default VPC
resource "aws_vpc" "default" {
  cidr_block       = "${var.vpc_cidr_block}"

  tags = {
    Name = "devops-challenge-apps-vpc"
  }
}
