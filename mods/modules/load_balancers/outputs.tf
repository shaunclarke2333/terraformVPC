output "main-elb-output" {
  description = "output for main-elb load balancer"
  value       = aws_lb.main-elb
}

output "main-target-group" {
  description = "output for main-target-group"
  value       = aws_lb_target_group.main-target-group
}
