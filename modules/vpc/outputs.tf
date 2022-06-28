#Output for main-vpc id
output "main-vpc-id" {
  description = "will be used by devices that depend on the vpc ID"
  value       = aws_vpc.my-main-vpc.id
  sensitive   = true
}

# Output for all main public subnets id
output "public_subnet" {
  description = "will be used by devices that depend on public subnet ID"
  value       = aws_subnet.public_subnet.id
  sensitive   = true
}

# Output for all main private subnets id
output "private_subnet" {
  description = "will be used by devices that depend on public subnet ID"
  value       = aws_subnet.private_subnet.id
  sensitive   = true
}

output "main-security-group-output" {
  description = "outputs the ID for main security group "
  value       = aws_security_group.main-elb-tcp80.id
}




