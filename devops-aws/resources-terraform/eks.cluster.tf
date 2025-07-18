resource "aws_eks_cluster" "this" {
  name = var.eks_cluster.name

  access_config {
    authentication_mode = var.eks_cluster.access_config_authentication_mode
  }

  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.31"

  enabled_cluster_log_types = var.eks_cluster.enabled_cluster_log_types

  vpc_config {
    subnet_ids = aws_subnet.privates[*].id
  }

  tags = var.tags
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_role_AmazonEKSClusterPolicy,
  ]
}