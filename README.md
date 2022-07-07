
Automating AWS VPC template build with Terraform layered approach.

This template contains the following resources with an S3 remote state backend configuration:
- VPC
- Two public subnets
- Two private subnets
- Internet gateway
- Two NAT gateways
- Public route table
- Private route table
- load balancer
- autoscaling group
- route53(dns)
- Launch template
- IAM role for Sessions Manager
- RDS
