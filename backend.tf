terraform {
    backend "s3" {
    bucket = "main-backend-state-bucket"
    key    = "mystate/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock-table"
  }
}