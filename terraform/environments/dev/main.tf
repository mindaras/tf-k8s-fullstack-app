provider "aws" {
  region = "eu-central-1"
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "${local.name_prefix}-vpc"
  cidr = var.vpc_cidr

  azs = data.aws_availability_zones.available.names
  public_subnets = [
    for index, az in data.aws_availability_zones.available.names :
    cidrsubnet(var.vpc_cidr, 8, index + 100)
  ]
  public_subnet_names = [
    for index, az in data.aws_availability_zones.available.names :
    "${local.name_prefix}-public-subnet-${index + 1}"
  ]

  enable_nat_gateway      = false
  map_public_ip_on_launch = true

  tags = local.common_tags
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "${local.name_prefix}-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = module.vpc.public_subnets
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${local.name_prefix}-eks-node-group"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = module.vpc.public_subnets

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ec2_container_registry_readonly,
  ]
}

