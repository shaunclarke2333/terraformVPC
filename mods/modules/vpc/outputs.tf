#Output for main-vpc id
output "main-vpc-id" {
  description = "will be used by devices that depend on the vpc ID"
  value       = aws_vpc.my-main-vpc.id
  sensitive   = true
}
