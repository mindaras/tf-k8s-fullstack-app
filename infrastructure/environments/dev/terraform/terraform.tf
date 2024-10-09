terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }

  backend "s3" {
    bucket         = "counter-app-development-terraform-state"
    key            = "eks-cluster/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "counter-app-development-terraform-locks"
    encrypt        = true
  }
}