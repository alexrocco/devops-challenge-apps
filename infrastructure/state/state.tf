provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "k8s-devops-challenge-apps-config" {
  bucket        = "k8s-devops-challenge-apps-config"
  force_destroy = true

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "terraform-devops-challenge-apps" {
  bucket        = "terraform-devops-challenge-apps"
  force_destroy = true
}

resource "aws_dynamodb_table" "terraform-state" {
  name           = "TerraformState"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
