
#AWS S3 full access policy
resource "aws_iam_role_policy" "s3-fullaccess-policy" {
  name = "main-s3-fullaccess-policy"
  role = aws_iam_role.main-s3-full-role.id

  policy = data.aws_iam_policy.s3-fullaccess-policy.policy
}

#S3 full access role to attach to asg
resource "aws_iam_role" "main-s3-full-role" {
  name = "main-S3-fullaccess"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "main-S3-fullaccess"
  }
}

# Resource block for instance profile
resource "aws_iam_instance_profile" "main-launch-temp-profile" {
  name = "main-launch-temp-profile"
  role = aws_iam_role.main-s3-full-role.name
}


