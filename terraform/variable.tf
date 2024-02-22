variable "ecs_cluster_name" {
  description = "The name for staging cluster"
  type        = string
  default     = "staging-apps"

}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["172.28.10.0/24", "172.28.11.0/24", "172.28.12.0/24"]
}

variable "private_subnet_names" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["Priv-Zone-A", "Priv-Zone-B", "Priv-Zone-C"]
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["172.28.0.0/24", "172.28.1.0/24", "172.28.2.0/24"]
}

variable "public_subnet_names" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["Public-Zone-A", "Public-Zone-B", "Public-Zone-C"]
}
variable "region" {
  description = "The AWS region to deploy the VPC into"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "The AWS region to deploy the VPC into"
  type        = string
  default     = "172.28.0.0/16"
}

variable "vpc_name" {
  description = "The VPC name for this aws account"
  type        = string
  default     = "staging"
}


variable "github_actions_user_name" {
  description = "Name of the IAM user for GitHub Actions"
  default     = "github-user"
}
