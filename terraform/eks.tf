resource "aws_eks_cluster" "cluster" {
  name     = "eks-ze-burguer"
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.eks-subnet.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.attach_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.attach_AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
}

resource "aws_eks_node_group" "ze-burguer-nodes"{
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "micro-node"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = aws_subnet.eks-subnet[*].id
  instance_types = ["t3.micro"]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 0
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.attach-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.attach-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.attach-AmazonEC2ContainerRegistryReadOnly,
  ]
}