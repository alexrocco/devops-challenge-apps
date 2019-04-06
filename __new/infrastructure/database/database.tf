terraform = {
  backend "s3" {
    bucket         = "terraform-devops-challenge-apps"
    key            = "network.tfstate"
    dynamodb_table = "TerraformState"
    region         = "us-east-1"
  }
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

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "devops-challenge-apps-db-subnet"
  subnet_ids = ["${data.terraform_remote_state.network.rds_subnet_1_id}", "${data.terraform_remote_state.network.rds_subnet_2_id}"]

  tags = {
    Name = "devops-challenge-apps-db-subnet"
  }
}

resource "random_string" "postgres_password" {
  length = 16
  special = false
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "10.6"
  instance_class       = "db.t2.micro"
  name                 = "devops-challenge-apps-postgres"
  username             = "${var.postgres_user}"
  password             = "${random_string.postgres_password.result}"
  db_subnet_group_name = "${aws_db_subnet_group.db_subnet_group.id}"
}
