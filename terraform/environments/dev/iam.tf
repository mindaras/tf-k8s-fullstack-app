# Cluster
data "aws_iam_policy_document" "eks_cluster_assume_role_policy" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name               = "${local.name_prefix}-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Node Group
data "aws_iam_policy_document" "eks_node_group_assume_role_policy" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_node_group_role" {
  name               = "${local.name_prefix}-eks-node-group-role"
  assume_role_policy = data.aws_iam_policy_document.eks_node_group_assume_role_policy.json
}

# Grants nodes the permissions they need to interact with the EKS control plane
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Grants permissions for the VPC CNI plugin, enabling networking for the pods
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# Allows the nodes to pull images from Amazon ECR
resource "aws_iam_role_policy_attachment" "eks_ec2_container_registry_readonly" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Allows access to EKS cluster for specified AWS profile
data "aws_iam_policy_document" "eks_profile_access_assume_role_policy" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.ci_user_id}:user/${var.ci_username}"]
    }
  }
}

resource "aws_iam_role" "eks_profile_access_role" {
  name               = "${local.name_prefix}-eks-profile-access-role"
  assume_role_policy = data.aws_iam_policy_document.eks_profile_access_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "eks_profile_access_policy" {
  role       = aws_iam_role.eks_profile_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
