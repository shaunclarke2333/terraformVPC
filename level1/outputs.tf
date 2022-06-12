#Output for main-vpc id
output "main-vpc-id" {
  description = "will be used by devices that depend on the vpc ID"
  value       = aws_vpc.my-main-vpc.id
  sensitive   = true
}

# Output for all main public subnets id
output "main-public-subnet" {
  description = "will be used by devices that depend on public subnet ID"
  value       = aws_subnet.public_subnet
  sensitive   = false
}

# Output for main-private0 subnet id
output "main-private-subnet" {
  description = "will be used by devices that depend on private subnet ID"
  value       = aws_subnet.private_subnet
  sensitive   = true
}
