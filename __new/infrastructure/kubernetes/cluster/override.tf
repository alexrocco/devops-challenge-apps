terraform = {
  backend "s3" {
    bucket         = "terraform-devops-challenge-apps"
    key            = "kubernetes.tfstate"
    dynamodb_table = "TerraformState"
    region         = "us-east-1"
  }
}
