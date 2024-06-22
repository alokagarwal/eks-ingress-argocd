module "eks_al2" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"

  # EKS Addons
  cluster_addons = {
    coredns = {
      addon_version = "v1.11.1-eksbuild.9"
    }
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  self_managed_node_groups = {
    spot = {
      instance_type = "t3.small"
      instance_market_options = {
        market_type = "spot"
      }

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

      # -     create_security_group          = true
      # -     security_group_name            = "eks-managed-node-group-complete-example"
      # -     security_group_use_name_prefix = false
      # -     security_group_description     = "EKS managed node group complete example security group"
      # -     security_group_rules = {}
      # -     security_group_tags = {}
    }
  }
  tags = var.additional_tags
}
