#Output for main-vpc id
output "main-vpc-id" {
  description = "will be used by devices that depend on the vpc ID"
  value       = aws_vpc.my-main-vpc.id
  sensitive   = true
}

# Output for all main public subnets id
output "public_subnet" {
  description = "will be used by devices that depend on public subnet ID"
  value       = aws_subnet.public_subnet
  sensitive   = true
}

# Output for all main private subnets id
output "private_subnet" {
  description = "will be used by devices that depend on public subnet ID"
  value       = aws_subnet.private_subnet
  sensitive   = true
}

output "elastic_ip_output" {
  description = "outputs for elastic ip "
  value       = aws_eip.nat
}

output "public_route_table_output" {
  description = "outputs for public route table "
  value       = aws_route_table.public_route_table
}

output "private_route_table_output" {
  description = "outputs for private route table "
  value       = aws_route_table.private_route_table
}

output "nat_gateway_output" {
  description = "outputs for nat gateway "
  value       = aws_nat_gateway.nat_gateway
}
