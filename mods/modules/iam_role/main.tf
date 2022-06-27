#Sessions Manager role
resource "aws_iam_role" "iam_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "${var.assume_role_policy_version}"
    Statement = [
      {
        Action = "${var.assume_role_policy_action}"
        Effect = "${var.assume_role_policy_effect}"
        Sid    = ""
        Principal = {
          Service = "${var.assume_role_policy_principal_service}"
        }
      },
    ]
  })

  tags = {
    Name = "${var.assume_role_policy_tag_name}"
  }
}
