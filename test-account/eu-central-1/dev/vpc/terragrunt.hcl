include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "common_locals" {
  path = find_in_parent_folders("common_locals.hcl")
  expose = true
  merge_strategy = "no_merge"
}

terraform {
  source = "https://github.com/mastercam123/tf-modules//vpc"
}

inputs = {
  vpc_name = "dev-vpc"
  vpc_azs = ["${include.common_locals.locals.region}a", "${include.common_locals.locals.region}b", "${include.common_locals.locals.region}c"]
  vpc_cidr = "10.15.0.0/16"
  vpc_public_subnets_cidr = ["10.15.100.0/24", "10.15.101.0/24","10.15.102.0/24"]
  vpc_private_subnets_cidr = ["10.15.0.0/24", "10.15.1.0/24","10.15.2.0/24"]
  public_subnets_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnets_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}