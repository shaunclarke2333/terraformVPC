#AWS policy for Amazon EC2 Role to enable AWS Systems Manager service core functionality
resource "aws_iam_role_policy" "session-mamanger-policy" {
  name   = "main-session-mamanger-policy"
  role   = aws_iam_role.ssm-full-access.id
  policy = data.aws_iam_policy.session-mamanger-policy.policy
}

#Sessions Manager role 
resource "aws_iam_role" "ssm-full-access" {
  name = "main-ssm-full-access"

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
    Name = "main-ssm-full-access"
  }
}

# Resource block for sessions manager  instance profile
resource "aws_iam_instance_profile" "main-session-manager-profile" {
  name = "main-session-manager-profile"
  role = aws_iam_role.ssm-full-access.name
}
