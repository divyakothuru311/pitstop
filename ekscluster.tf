module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

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

  vpc_id                   = "vpc-0b321eec0b173770f"
  subnet_ids               = ["subnet-04823f11b2b1f855e", "subnet-09b1d6c52e8f5cc4d"]
  control_plane_subnet_ids = ["subnet-04823f11b2b1f855e", "subnet-09b1d6c52e8f5cc4d"]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t2.large", "t2.large"]
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t2.large"]
      capacity_type  = "SPOT"
    }
  }
}