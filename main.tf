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
  tags        = var.tags
}

module "cdn" {
  source      = "./modules/cdn"
  domain_name = var.domain_name
  s3_origin   = module.hosting_bucket.bucket_website_endpoint
}

module "dns" {
  source             = "./modules/dns"
  record_name        = var.domain_name
  distribution       = module.cdn.endpoint
  cloudfront_zone_id = module.cdn.zone_id
}

output "s3_endpoint" {
  value = module.hosting_bucket.bucket_website_endpoint
}

output "cdn_endpoint" {
  value = module.cdn.endpoint
}

output "alternate_domain_name" {
  value = var.domain_name
}
