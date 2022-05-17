data "aws_availability_zones" "azs" {}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = var.vpc.name
  cidr = var.vpc.cidr

  azs             = data.aws_availability_zones.azs.names
  private_subnets = var.vpc.private_subnets
  public_subnets  = var.vpc.public_subnets

  enable_nat_gateway   = var.vpc.enable_nat_gateway
  single_nat_gateway   = var.vpc.single_nat_gateway
  enable_dns_hostnames = var.vpc.enable_dns_hostnames


  public_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                                = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"                       = 1
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = var.eks_cluster.cluster_name
  cluster_version = var.eks_cluster.cluster_version

  cluster_endpoint_private_access = var.eks_cluster.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.eks_cluster.cluster_endpoint_public_access


  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    disk_size      = var.managed_node.disk_size
    instance_types = var.managed_node.default_instance_types
  }
  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = var.managed_node.min_size
      max_size     = var.managed_node.max_size
      desired_size = var.managed_node.desired_size

      instance_types = var.managed_node.instance_types
      capacity_type  = var.managed_node.capacity_type
    }
  }
  tags = var.managed_node.tags
}