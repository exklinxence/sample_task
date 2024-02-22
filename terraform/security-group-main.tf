resource "aws_security_group" "eks" {
  name_prefix = "eks-"
  description = "Security group for EKS cluster"
  vpc_id      = module.vpc_staging.vpc_id
  ingress {
    description = "Allow inbound traffic from within the VPC"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

output "eks_security_group_id" {
  value = aws_security_group.eks.id
}
