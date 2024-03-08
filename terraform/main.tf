terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
      }
    }
    required_version = ">= 1.2.0"
}

provider "aws" {
    region = "us-east-1"
}


# data "aws_vpc" "vpc"{
#   id = "vpc-0eb005509252e5509"
# }

# data "aws_subnet_ids" "eks_subnet" {
#   vpc_id = "${data.aws_vpc.vpc.id}"
#   tags = {
#     Name = "eks-subnet*"
#   }
# }

# data "aws_subnet" "eks_subnet" {
#   filter {
#     name   = "tag:Resource"
#     values = ["eks"]
#   }
# }

data "aws_subnet" "eks_subnet_1" {
  id = "subnet-0d54589568705e53e"
}

data "aws_subnet" "eks_subnet_2" {
  id = "subnet-0ddcc9607d3c7aec5"
}
