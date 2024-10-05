locals {
  record_parts = split(".", var.record_name)
}

data "aws_route53_zone" "selected" {
  name         = join(".", slice(local.record_parts, 1, length(local.record_parts)))
  private_zone = false
}

resource "aws_route53_record" "site" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.record_name

  type = "A"
  alias {
    name = var.distribution
    zone_id = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}