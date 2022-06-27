output "ssm-iam-role-output" {
  description = "this outputs the iam role attributes"
  value       = aws_iam_role.iam_role
}
