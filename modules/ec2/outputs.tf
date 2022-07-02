output "main-autoscaling-group" {
  description = "output from the main-autoscaling-group"
  value       = aws_autoscaling_group.main-autoscaling-group
  sensitive   = true
}

output "ec2-security-group-id" {
  description = "outputs the ID from the main-elb-tcp80 security group"
  value       = aws_security_group.main-elb-tcp80.id
  sensitive   = false
}
