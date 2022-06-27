# Terraform block with required provider and terraform version listed
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">=0.14.9"
}

# Provider block with region defined
provider "aws" {
  region = "us-east-1"
}

# S3 bucket that holds state file
module "main-s3bucket" {
  source                = "../mods/modules/s3bucket"
  bucket                = "main-backend-state-bucket"
  force_destroy         = true
  bucket_key_enabled    = false
  algorithm             = "AES256"
  versioning_enabled    = true
  versioning_mfa_delete = false
}

#Adding folders to S3 bucket
module "state_file_folders" {
  for_each = toset(var.bucket_folders)

  source                 = "../mods/modules/s3folders"
  bucket_name            = module.main-s3bucket.aws_s3_bucket_output.bucket
  folder_name            = each.value
  server_side_encryption = "AES256"
}

# Dynamodb table to use for terraform state locking
module "main-terraformstatelock" {
  source                         = "../mods/modules/dynamodb"
  billing_mode                   = "PROVISIONED"
  hash_key                       = "LockID"
  table_name                     = "terraform-state-lock-table"
  read_capacity                  = 1
  stream_enabled                 = false
  write_capacity                 = 1
  attribute_name                 = "LockID"
  attribute_type                 = "S"
  point_in_time_recovery_enabled = false
}


