output "main_launch_template" {
  description = "output for main launch template"
  value       = aws_launch_template.launch-template
  sensitive   = true
}
