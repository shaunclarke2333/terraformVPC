# Output for all main public subnets id
output "subnet" {
  description = "will be used by devices that depend on public subnet ID"
  value       = aws_subnet.main_subnet
  sensitive   = true
}
