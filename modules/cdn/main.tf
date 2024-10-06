terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  alias = "us-east-1"
  region = "us-east-1"
}

data "aws_acm_certificate" "custom_certificate_arn" {
  provider = aws.us-east-1
  domain = var.domain_name
  statuses = [ "ISSUED" ]
}

data "aws_cloudfront_cache_policy" "optimised" {
  name = "Managed-CachingOptimized"
}

resource "random_id" "origin_id" {
  byte_length = 8
}

resource "aws_cloudfront_distribution" "bucket_distro" {
  origin {
    domain_name = var.s3_origin
    origin_id = random_id.origin_id.id

    # This custom origin config is REQUIRED if your bucket serves as a website
    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = [ "TLSv1.2" ]
    }
  }

  aliases = [ var.domain_name ]
  
  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = data.aws_acm_certificate.custom_certificate_arn.arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
  
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations = var.whitelist_country
    }
  }
  
  default_cache_behavior {
    viewer_protocol_policy = "allow-all"
    allowed_methods = [ "GET", "HEAD" ]
    cached_methods = [ "GET", "HEAD" ]
    target_origin_id = random_id.origin_id.id

    cache_policy_id = data.aws_cloudfront_cache_policy.optimised.id
  }
  
  enabled = true

  # This will omit the deployment and deletion time 
  wait_for_deployment = false
  retain_on_delete = true
}