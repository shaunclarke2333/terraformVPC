# Dynamodb table to use for terraform state locking
resource "aws_dynamodb_table" "main-terraformstatelock" {
  billing_mode   = "PROVISIONED"
  hash_key       = "LockID"
  name           = "terraform-state-lock-table"
  read_capacity  = 1
  stream_enabled = false
  tags           = {}
  tags_all       = {}
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = false
  }

  timeouts {}

  lifecycle {
    prevent_destroy = true
  }

}

