module "eks" {
  source = "github.com/ManagedKube/kubernetes-ops//terraform-modules/aws/eks?ref=v1.0.30"

  aws_region = local.aws_region
  tags       = local.tags

  cluster_name = local.environment

  vpc_id         = module.vpc_staging.vpc_id
  k8s_subnets    = module.vpc_staging.private_subnets
  public_subnets = module.vpc_staging.public_subnets

  cluster_version = "1.29"

  # public cluster - kubernetes API is publicly accessible
  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = [
    "0.0.0.0/0",
    "1.1.1.1/32",
  ]

  # private cluster - kubernetes API is internal the the VPC
  cluster_endpoint_private_access                = true
  cluster_create_endpoint_private_access_sg_rule = true
  cluster_endpoint_private_access_cidrs = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
    "100.64.0.0/16",
  ]

  # Add whatever roles and users you want to access your cluster
  map_roles = [
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/role1"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]
  map_users = [
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/username"
      username = "username"
      groups   = ["system:masters"]
    },
  ]

  node_groups = {
    ng1 = {
      version          = "1.29"
      disk_size        = 20
      desired_capacity = 2
      max_capacity     = 4
      min_capacity     = 1
      instance_types   = ["t3.small"]
      additional_tags  = local.tags
      k8s_labels       = {}
    }
  }
}
