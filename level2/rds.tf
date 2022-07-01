# RDS resource
module "main-rds" {
  source = "../modules/rds"

  #subnet group for private subnets
  subnet_group_name       = "main-subnet-group"
  subnet_group_subnet_ids = [for pvt-subnet in data.terraform_remote_state.level1-main-vpc.outputs.main-private-subnet : pvt-subnet.id]
  tag_db_subnet_group     = "main-db"

  # parameter group to definemysql config settings
  db_parameter_group_name   = "main-mysql8"
  db_parameter_group_family = "mysql8.0"

  # Security group to Allow port 3306 TCP inbound to RDS
  sg_name        = "main-rds-security-group"
  sg_description = "Allow port 3306 TCP inbound"
  sg_vpc_id      = data.terraform_remote_state.level1-main-vpc.outputs.main-vpc-id

  #ingress
  sg_ingress_description     = "3306 sql port inbound"
  sg_ingress_from_port       = 3306
  sg_ingress_to_port         = 3306
  sg_ingress_protocol        = "tcp"
  sg_ingress_security_groups = ["${module.main-autoscaling-group.ec2-security-group-id}"]

  #egress
  sg_egress_from_port   = 0
  sg_egress_to_port     = 65535
  sg_egress_protocol    = "tcp"
  sg_egress_cidr_blocks = ["0.0.0.0/0"]

  #tags
  sg_tag_name = "main-rds"

  # RDS instance
  db_identifier           = "main-mysql-database"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  db_port                 = "3306"
  rds_name                = "mydb"
  rds_username            = "admin"
  skip_final_snapshot     = true
  multi_az                = true
  backup_retention_period = 1
  backup_window           = "09:46-10:16"
}
