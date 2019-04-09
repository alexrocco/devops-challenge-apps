terraform = {
  backend "s3" {
    bucket         = "terraform-devops-challenge-apps"
    key            = "database.tfstate"
    dynamodb_table = "TerraformState"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

output "username" {
  value = "${var.postgres_user}"
}

output "password" {
  value =  "${random_string.postgres_password.result}"
}

output "endpoint" {
  value = "${aws_db_instance.postgres.endpoint}"
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config {
    bucket         = "terraform-devops-challenge-apps"
    key            = "network.tfstate"
    dynamodb_table = "TerraformState"
    region         = "us-east-1"
  }
}

data "terraform_remote_state" "kubernetes" {
  backend = "s3"

  config {
    bucket         = "terraform-devops-challenge-apps"
    key            = "kubernetes.tfstate"
    dynamodb_table = "TerraformState"
    region         = "us-east-1"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "devops-challenge-apps-db-subnet"
  subnet_ids = ["${data.terraform_remote_state.network.rds_subnet_1_id}", "${data.terraform_remote_state.network.rds_subnet_2_id}"]

  tags = {
    Name = "devops-challenge-apps-db-subnet"
  }
}

resource "aws_security_group" "postgres_sg" {
  name        = "devops-challenge-apps-postgres-sq"
  vpc_id      = "${data.terraform_remote_state.network.vpc_id}"

  ingress {
    from_port       = 0
    to_port         = 5432
    protocol        = "TCP"
    security_groups = ["${data.terraform_remote_state.kubernetes.node_security_group_ids}", "${data.terraform_remote_state.kubernetes.bastion_security_group_ids}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "random_string" "postgres_password" {
  length = 16
  special = false
}

resource "aws_db_instance" "postgres" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "10.6"
  instance_class         = "db.t2.micro"
  identifier             = "devops-challenge-apps-postgres"
  username               = "${var.postgres_user}"
  password               = "${random_string.postgres_password.result}"
  db_subnet_group_name   = "${aws_db_subnet_group.db_subnet_group.id}"
  skip_final_snapshot    = true
  vpc_security_group_ids = ["${aws_security_group.postgres_sg.id}"]
}
