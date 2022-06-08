#Output for main-vpc id
output "main-vpc-id" {
  description = "will be used by devices that depend on the vpc ID"
  value       = aws_vpc.my-main-vpc.id
  sensitive = true
}

# Output for main-public0 subnet id
output "main-public0-subnet" {
  description = "will be used by devices that depend on main-public0 subnet ID"
  value       = aws_subnet.public_subnet[0].id
  sensitive = true
}