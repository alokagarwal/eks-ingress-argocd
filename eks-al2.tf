module "eks_al2" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.14.0"

  cluster_name                    = var.cluster_name
  cluster_version                 = "1.30"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  # EKS Addons
  cluster_addons = {
    coredns = {
      addon_version = "v1.11.1-eksbuild.9"
    }
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id = aws_vpc.main.id
  subnet_ids = [
    aws_subnet.private1.id,
    aws_subnet.private2.id
  ]

  self_managed_node_groups = {
    spot = {
      instance_type = "t3.small"
      instance_market_options = {
        market_type = "spot"
      }
      //override_instance_types = ["m5.large", "m5a.large", "m5d.large", "m5ad.large"]
      # spot_instance_pools     = 4
      # asg_max_size            = 5
      # asg_desired_capacity    = 5
      # pre_bootstrap_user_data = <<-EOT
      #   echo "foo"
      #   export FOO=bar
      # EOT

      bootstrap_extra_args = "--kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot'"

      post_bootstrap_user_data = <<-EOT
        cd /tmp
        sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
        sudo systemctl enable amazon-ssm-agent
        sudo systemctl start amazon-ssm-agent
      EOT

      # -create_security_group          = true
      # -security_group_name            = "eks-managed-node-group-complete-example"
      # -security_group_use_name_prefix = false
      # -security_group_description     = "EKS managed node group complete example security group"
      # -security_group_rules           = {}
      # -security_group_tags            = {}
    }
  }

  enable_cluster_creator_admin_permissions = true

  # access_entries = {
  #   # One access entry with a policy associated
  #   # ex-single = {
  #   #   kubernetes_groups = []
  #   #   principal_arn     = "arn:aws:iam::846558749899:user/devopsy"

  #   #   # policy_associations = {
  #   #   #   single = {
  #   #   #     policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
  #   #   #     access_scope = {
  #   #   #       type = "cluster"
  #   #   #     }
  #   #   #   }
  #   #   # }
  #   # }

  #   # # Example of adding multiple policies to a single access entry
  #   # ex-multiple = {
  #   #   kubernetes_groups = []
  #   #   principal_arn     = aws_iam_role.this["multiple"].arn

  #   #   policy_associations = {
  #   #     ex-one = {
  #   #       policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSEditPolicy"
  #   #       access_scope = {
  #   #         namespaces = ["default"]
  #   #         type       = "namespace"
  #   #       }
  #   #     }
  #   #     ex-two = {
  #   #       policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
  #   #       access_scope = {
  #   #         type = "cluster"
  #   #       }
  #   #     }
  #   #   }
  #   # }
  # }
  tags = var.additional_tags
}
