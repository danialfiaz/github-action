vpc = {
  name                 = "my-vpc"
  cidr                 = "10.0.0.0/16"
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
}

eks_cluster = {
  cluster_name                    = "my-cluster"
  cluster_version                 = "1.21"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
}

managed_node = {
  disk_size              = 50
  default_instance_types = ["t2.small"]
  min_size               = 1
  max_size               = 3
  desired_size           = 1
  instance_types         = ["t2.small"]
  capacity_type          = "ON_DEMAND"
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
aws = {
  region = "us-east-2"
}
