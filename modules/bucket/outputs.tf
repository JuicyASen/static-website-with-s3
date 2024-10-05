output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}

output "bucket_region" {
  value = aws_s3_bucket.bucket.region
}

output "bucket_index" {
  value = aws_s3_bucket_website_configuration.bucket_hosting_config.index_document
}

output "bucket_website_endpoint" {
  value = aws_s3_bucket_website_configuration.bucket_hosting_config.website_endpoint
}