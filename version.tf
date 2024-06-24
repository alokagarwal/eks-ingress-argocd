
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
    bucket  = "devopsy-terraform"
    key     = "eks_ingress_argocd/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    //dynamodb_table = "eks-spike-terraform-state-lock"
    profile = "techwithalok"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.40"
    }
  }
}
