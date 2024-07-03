resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.nodes.arn
  

  subnet_ids = [
    var.private_subnet_1,
    var.private_subnet_2
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = [var.instance_type]
  disk_size      = 10

  scaling_config {
    desired_size = 2
    max_size     = 6
    min_size     = 2
  }

  update_config {
    max_unavailable = var.max_available_config
  }

  labels = {
    role = "production"
  }
}


