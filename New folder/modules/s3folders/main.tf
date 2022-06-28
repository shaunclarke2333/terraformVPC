# Resource block to create S3 bucket objects(folders)
resource "aws_s3_bucket_object" "main-object" {
  bucket                 = var.bucket_name
  key                    = var.folder_name
  server_side_encryption = var.server_side_encryption
}
