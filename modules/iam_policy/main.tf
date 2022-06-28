# AWS policy for Amazon EC2 Role to enable AWS Systems Manager service core functionality
resource "aws_iam_role_policy" "iam_role_policy" {
  name   = var.policy_name
  role   = var.policy_role
  policy = var.policy
}
