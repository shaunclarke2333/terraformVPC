output "iam_instance_profile_output" {
  description = "outputs the name for the iam instance profile"
  value       = aws_iam_instance_profile.iam_instance_profile.name
}
