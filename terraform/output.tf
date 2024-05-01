output "cluster_name" {
  value = aws_eks_cluster.cluster.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "cluster_node_group" {
  value = aws_eks_node_group.ze-burguer-nodes.node_group_name
}

output "cluster_node_group_type" {
  value = aws_eks_node_group.ze-burguer-nodes.instance_types
}