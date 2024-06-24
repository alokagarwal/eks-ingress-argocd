

variable "cluster_name" {
  type        = string
  description = "Cluster Name"
  default     = "eks-spike"
}
#VPC Info
variable "vpc_name" {
  type        = string
  description = "VPC Name"
  default     = "default"
}

variable "vpc_id" {
  type        = string
  description = "VPC Id"
  //default     = "vpc-3bd2ef5e"
  default = "vpc-077dfc31312e07378"
}

# variable "vpc_cidr_block" {
#   type        = string
#   description = "value of the CIDR block to use for the VPC"
#   default     = "172.31.0.0/16"
# }

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

variable "aws_profile" {
  type    = string
  default = "techwithalok"
}


variable "argocd_chart_name" {
  type    = string
  default = "argo-cd"
}


variable "argocd_chart_version" {
  type    = string
  default = "7.2.1"
}


variable "argocd_k8s_namespace" {
  type    = string
  default = "argocd"
}
