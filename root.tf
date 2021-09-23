terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

## VPC
module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  enable_dns     = true
  tag_name       = var.tag_name
  tag_cost       = var.tag_cost
}

## Subnet
module "sbn" {
  source      = "./modules/subnet"
  vpc_id      = module.vpc.id
  cidr_block  = module.vpc.cidr_block
  igw         = module.vpc.igw
  az          = var.az
  az_list     = var.az_list
  pub_ip      = true
  pub_sbn_cnt = var.pub_sbn_cnt
  pvt_sbn_cnt = var.pvt_sbn_cnt
  tag_name    = var.tag_name
  tag_cost    = var.tag_cost
}
