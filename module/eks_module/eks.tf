resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name
  version = var.kubernetes_version
  role_arn = aws_iam_role.cluster-role.arn


  vpc_config {
    subnet_ids =[
        var.public_subnet_1,
        var.public_subnet_2,
        var.private_subnet_1,
        var.private_subnet_2
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
  ]
}

#Create IAM OIDC provider EKS using Terraform

data "tls_certificate" "eks_tls" {
  url = aws_eks_cluster.my_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_tls.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.my_cluster.identity[0].oidc[0].issuer
}