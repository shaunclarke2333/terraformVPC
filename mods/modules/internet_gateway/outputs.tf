output "internet_gateway_id" {
  description = "output of internet gateway id from module"
  value       = aws_internet_gateway.internet_gateway.id
  sensitive   = false
}
