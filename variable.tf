variable "vpc" {
  type = object({
    name                 = string
    cidr                 = string
    private_subnets      = list(string)
    public_subnets       = list(string)
    enable_nat_gateway   = bool
    single_nat_gateway   = bool
    enable_dns_hostnames = bool
  })
}

variable "eks_cluster" {
  type = object({
    cluster_name                    = string
    cluster_version                 = string
    cluster_endpoint_private_access = bool
    cluster_endpoint_public_access  = bool
  })
}

variable "managed_node" {
  type = object({
    disk_size              = number
    default_instance_types = list(string)
    min_size               = number
    max_size               = number
    desired_size           = number
    instance_types         = list(string)
    capacity_type          = string
    tags                   = map(string)
  })
}

variable "aws" {
  type = object({
    region = string
  })
}