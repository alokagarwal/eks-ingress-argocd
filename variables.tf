

variable "cluster_name" {
  type        = string
  description = "Cluster Name"
  default     = "eks-spike"
}
#VPC Info
variable "vpc_name" {
  type        = string
  description = "VPC Name"
  default     = "eks-vpc"
}

variable "vpc_id" {
  type        = string
  description = "VPC Id"
  default     = "vpc-05e88fbb4861fd9d6"
}

variable "vpc_cidr_block" {
  type        = string
  description = "value of the CIDR block to use for the VPC"
  default     = "172.16.0.0/16"
}

variable "private_subnet_ids" {
  type        = list(any)
  description = "private subnets ids"
  default     = ["subnet-0eb2651ab1511acd3", "subnet-0168c949f8067db21", "subnet-0f0f4c6e5b2548640"]
}

#AWS Info
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "additional_tags" {
  default = {
    environment = "dev"
  }
  description = "Additional AWS resource tags"
  type        = map(string)
}

