terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {}

variable "domain_name" {
  type = string 
}

variable "tags" {
  type = map(string)
  default = {
    "Written By" = "Yc Wang"
  }
}

# Resources and Modules go here
module "hosting_bucket" {
  source = "./modules/bucket"

  bucket_name = var.domain_name
  tags = var.tags
}