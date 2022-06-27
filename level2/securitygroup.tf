# Security group for the main-loab-balancer Allow port 80 TCP inbound to ELB
module "main-elb-tcp80" {
  source = "../mods/modules/security_group"
  sg_name = "main-load-balancer"
  sg_description = "Allow port 80 TCP inbound to ELB"
  vpc_id = data.terraform_remote_state.level1-main-vpc.outputs.main-vpc-id
  
  #ingress
  sg_ingress_description = "http to ELB"
  sg_ingress_from_port = 80
  sg_ingress_to_port = 80
  sg_ingress_protocol = "tcp"
  sg_ingress_cidr_blocks = ["0.0.0.0/0"]

  #egress
  sg_egress_from_port = 0
  sg_egress_to_port = 65535
  sg_egress_protocol = "tcp"
  sg_egress_cidr_blocks = ["0.0.0.0/0"]

  #tags
  sg_tag_name = "main-load-balancer"
}
