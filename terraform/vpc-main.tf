module "vpc_staging" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.5.0"

  name = local.vpc_name
  cidr = local.vpc_cidr

  azs = local.azs

  public_subnets       = local.public_subnets
  public_subnet_names  = local.public_subnet_names
  public_subnet_tags   = local.public_subnet_tag
  private_subnets      = local.private_subnets
  private_subnet_names = local.private_subnet_names
  private_subnet_tags  = local.private_subnet_tags
  igw_tags             = local.tags


  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  tags = local.tags
}
