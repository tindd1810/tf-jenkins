terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "tindd-terraform-state-prod"
    key    = "vpc/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "vpc" {
  source = "git@github.com:tindd1810/re-modules.git//vpc"
  sg-name = "tindd-sg-testing"
}

output "sg-id" {
  value = module.vpc.sg-id
}
output "vpc-id" {
  value = module.vpc.vpc-id
}