provider "aws" {
  region = "us-east-1"  # Specify your desired region here
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.29"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = "vpc-0693f21ebb7c713de"
  subnet_ids               = ["subnet-038fe6e5c03f357d8", "subnet-0f6a67fd2e1118f5b", "subnet-08c188d9754b42690"]
  control_plane_subnet_ids = ["subnet-0661407452b94b9b8", "subnet-01747970d3b34a269", "subnet-04da01058ddceead4"]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3.small"]
  }

  eks_managed_node_groups = {
    example = {
      min_size     = 1
      max_size     = 1
      desired_size = 1

      instance_types = ["t3.small"]
      capacity_type  = "SPOT"
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
