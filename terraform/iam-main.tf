resource "aws_iam_user" "github_actions_user" {
  name = var.github_actions_user_name
}

resource "aws_iam_access_key" "github_actions_access_key" {
  user = aws_iam_user.github_actions_user.name
}

output "github_actions_access_key_id" {
  value = aws_iam_access_key.github_actions_access_key.id
}

output "github_actions_access_key_secret" {
  value     = aws_iam_access_key.github_actions_access_key.secret
  sensitive = true
}


resource "aws_iam_policy" "eks_deployment_policy" {
  name        = "eks_deployment_policy"
  description = "Policy for deploying to Amazon EKS"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:CreateCluster",
          "eks:UpdateClusterConfig",
          "eks:DescribeNodegroup",
          "eks:CreateNodegroup",
          "eks:UpdateNodegroupConfig",
          "eks:ListClusters",
          "eks:ListUpdates",
          "eks:DescribeUpdate",
          "eks:TagResource",
          "eks:UntagResource",
          "eks:ListTagsForResource"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "eks_deployment_attachment" {
  user       = aws_iam_user.github_actions_user.name
  policy_arn = aws_iam_policy.eks_deployment_policy.arn
}




#EKS IAM ROLE

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "eks_cluster_policy_attachment" {
  name       = "eks-cluster-attachment"
  roles      = [aws_iam_role.eks_cluster_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_policy_attachment" "eks_service_policy_attachment" {
  name       = "eks-service-attachment"
  roles      = [aws_iam_role.eks_cluster_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_policy_attachment" "eks_node_policy_attachment" {
  name       = "eks-node-attachment"
  roles      = [aws_iam_role.eks_cluster_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_policy_attachment" "eks_cni_policy_attachment" {
  name       = "eks-cni-attachment"
  roles      = [aws_iam_role.eks_cluster_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

