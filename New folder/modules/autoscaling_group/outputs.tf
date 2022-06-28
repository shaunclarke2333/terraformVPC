output "main-autoscaling-group" {
  description = "output from the main-autoscaling-group"
  value       = aws_autoscaling_group.main-autoscaling-group
  sensitive   = true
}