output "endpoint" {
  value = aws_cloudfront_distribution.bucket_distro.domain_name
}

output "zone_id" {
  value = aws_cloudfront_distribution.bucket_distro.hosted_zone_id
}