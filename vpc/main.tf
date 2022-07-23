terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "dinhlehoangdemo-terraform-state-testing"
    key    = "vpc/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "vpc" {
  source = "github.com/hoangledinh65/terraform-module//vpc?ref=testing"
  sg-name = "hoangdl-sg-testing"
}

output "sg-id" {
  value = module.vpc.sg-id
}
output "vpc-id" {
  value = module.vpc.vpc-id
}