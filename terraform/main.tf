terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
      }
    }
    required_version = ">= 1.2.0"

    backend "s3" {
    bucket = "ze-burger-tfstate"
    key = "terraform-eks-state"
    region = "us-east-1"
  }
}

provider "aws" {
    region = "us-east-1"
}

data "aws_subnet" "eks_subnet_1" {
  id = "subnet-0333ede7b0e3e8cd4"
}

data "aws_subnet" "eks_subnet_2" {
  id = "subnet-0c7b6fa644ab7b70b"
}
