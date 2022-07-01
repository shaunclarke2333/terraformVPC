#Declaring availability zone data source
data "aws_availability_zones" "available" {
  state = "available"
}

#Datasource for RDS password secret
data "aws_secretsmanager_secret" "rds-secret" {
  arn = "arn:aws:secretsmanager:us-east-1:003729975368:secret:main-rds-password-lS7Tso"
}

#Data source to retreive values from secret manager
data "aws_secretsmanager_secret_version" "rds-secret-password" {
  secret_id = data.aws_secretsmanager_secret.rds-secret.id
}

#subnet group for private subnets
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_group_subnet_ids

  tags = {
    Name = "${var.tag_db_subnet_group}-subnet-group"
  }
}

# parameter group to definemysql config settings
resource "aws_db_parameter_group" "db_parameter_group" {
  name   = var.db_parameter_group_name
  family = var.db_parameter_group_family

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

# Security group for to allow inbounf traffic to 
resource "aws_security_group" "main-elb-tcp80" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.sg_vpc_id

  ingress {
    description     = var.sg_ingress_description
    from_port       = var.sg_ingress_from_port
    to_port         = var.sg_ingress_to_port
    protocol        = var.sg_ingress_protocol
    security_groups = var.sg_ingress_security_groups
  }

  egress {
    from_port   = var.sg_egress_from_port
    to_port     = var.sg_egress_to_port
    protocol    = var.sg_egress_protocol
    cidr_blocks = var.sg_egress_cidr_blocks
  }

  tags = {
    Name = "${var.sg_tag_name}-sg"
  }
}

# Module for RDS instance
resource "aws_db_instance" "default" {
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  port                    = var.db_port
  name                    = var.rds_name
  username                = var.rds_username
  password                = data.aws_secretsmanager_secret_version.rds-secret-password
  parameter_group_name    = var.parameter_group_name
  skip_final_snapshot     = var.skip_final_snapshot
  multi_az                = var.multi_az
  vpc_security_group_ids  = var.vpc_security_group_ids
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
}
