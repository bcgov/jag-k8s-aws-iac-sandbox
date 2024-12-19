resource "aws_s3_bucket_versioning" "tf_state_bucket_versioning" {
  bucket = data.aws_s3_bucket.sandbox_s3.id

  versioning_configuration {
    status = "Enabled"  # Enable versioningxxxx
  }
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.kubernetes_version
  
  vpc_config {
    subnet_ids = [
      data.aws_subnet.app_tools_aza_net.id,
      data.aws_subnet.data_tools_azb_net.id,
    ]
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name = var.eks_cluster_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Effect = "Allow"
      Sid = ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role" "eks_node_role" {
  name = var.eks_node_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Effect = "Allow"
      Sid = ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_node_role.arn
  
subnet_ids = [
    data.aws_subnet.app_tools_aza_net.id,
    data.aws_subnet.data_tools_azb_net.id,
  ]

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }

  instance_types  = ["m7i.4xlarge"] 
  ami_type       = "AL2_x86_64" 
  disk_size      = 50    
  version        = var.kubernetes_version

  tags = {
    Name = var.node_group_name
  }
}
