
# terraform {
#   required_version = ">= 1.3.2"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = ">= 5.40"
#     }
#   }
# }


terraform {
  required_version = ">= 1.3.2"
  backend "s3" {
    bucket         = "terraform-state-files"
    key            = "statefiles/eks_spike_cluster/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "eks-spike-terraform-state-lock"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.40"
    }
  }
}
