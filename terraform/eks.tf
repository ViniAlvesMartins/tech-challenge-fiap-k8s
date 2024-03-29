resource "aws_eks_cluster" "cluster" {
  name     = "eks-ze-burguer"
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids =  [ data.aws_subnet.eks_subnet_1.id, data.aws_subnet.eks_subnet_2.id ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  # Run Terraform!
  depends_on = [
    aws_iam_role_policy_attachment.attach_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.attach_AmazonEKSVPCResourceController,
    data.aws_subnet.eks_subnet_1,
    data.aws_subnet.eks_subnet_2
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
  subnet_ids      = [ data.aws_subnet.eks_subnet_1.id, data.aws_subnet.eks_subnet_2.id ]
  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  depends_on = [
    aws_iam_role_policy_attachment.attach-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.attach-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.attach-AmazonEC2ContainerRegistryReadOnly,
    data.aws_subnet.eks_subnet_1,
    data.aws_subnet.eks_subnet_2
  ]
}