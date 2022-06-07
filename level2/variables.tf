# instance type for ec2
variable "instance_type" {
  description = "instance type for ec2"
  default     = "t2.small"
}

# key to connect to ec2
variable "key_name" {
  description = "key to connect to main-ec2 resource"
  default     = "main"

}
# variable for main-public0 public subnet ID
variable "subnetid" {
  description = "variable for main-public0 public subnet ID"
  default = "subnet-08056f0e3a471d580"
}
# variable for main-vpc ID
variable "vpcid" {
  description = "variable for main-vpc ID"
  default = "vpc-073daf4e39f7b81ee"
}
