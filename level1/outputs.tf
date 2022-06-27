#Output for main-vpc id
output "main-vpc-id" {
  description = "will be used by devices that depend on the vpc ID"
  value       = module.my-main-vpc.main-vpc-id
  sensitive   = true
}

# Output for all main public subnets id
output "main-public-subnet" {
  description = "will be used by devices that depend on public subnet ID"
  value       = [for subnet in module.main_public_subnet : subnet.subnet]
  sensitive   = true
}

# Output for main-private subnet id
output "main-private-subnet" {
  description = "will be used by devices that depend on private subnet ID"
  value       = [for subnet in module.main_private_subnet : subnet.subnet]
  sensitive   = true
}
