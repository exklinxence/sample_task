locals {
  azs         = ["${var.region}a", "${var.region}b", "${var.region}c"]
  environment = "staging"

  name = "sample"


  private_subnets      = var.private_subnets
  private_subnet_names = var.private_subnet_names
  private_subnet_tags = {
    Tier = "private-subnet"
  }

  public_subnets      = var.public_subnets
  public_subnet_names = var.public_subnet_names
  public_subnet_tag = {
    Tier = "public-subnet"
  }

  ecs_cluster_name = var.ecs_cluster_name

  owner    = "staging"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name

  tags = {
    Owner       = local.owner
    Environment = local.environment
    Terraform   = "true"
  }
}
