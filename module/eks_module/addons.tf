resource "aws_eks_addon" "core_dns" {
  cluster_name                = aws_eks_cluster.my_cluster.name
  addon_name                  = var.core_dns
  addon_version               = var.core_dns_version
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "vpc_cni" {
    cluster_name = aws_eks_cluster.my_cluster.name
    addon_name = var.vpc_cni
    addon_version = var.vpc_cni_version

  
}

resource "aws_eks_addon" "kube_proxy" {
    cluster_name = aws_eks_cluster.my_cluster.name
    addon_name = var.kube_proxy
    addon_version = var.kube_proxy_version
  
}