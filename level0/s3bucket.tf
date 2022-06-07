# S3 bucket that holds state file
resource "aws_s3_bucket" "main-s3bucket" {
  bucket = "main-backend-state-bucket"

  server_side_encryption_configuration {
    rule {
      bucket_key_enabled = false

      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled    = true
    mfa_delete = false
  }

  lifecycle {
    prevent_destroy = true
  }
}