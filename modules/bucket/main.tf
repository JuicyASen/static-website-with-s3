resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_website_configuration" "bucket_hosting_config" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = var.index_key
  }
}

resource "aws_s3_bucket_public_access_block" "unblock_public_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_all_access" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.allow_access_anywhere.json

  /* 
  This is important because Terraform creates these resources in parallel,
  which could lead to a 403 when creating this policy,
  as the inclusion of wildcards in principals is not allowed when a bucket is considered non-public.
  */
  depends_on = [ aws_s3_bucket_public_access_block.unblock_public_access ]
}

data "aws_iam_policy_document" "allow_access_anywhere" {
  statement {
    principals {
      type = "*"
      identifiers = [ "*" ]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}

resource "aws_s3_object" "index_document" {
  bucket = aws_s3_bucket.bucket.bucket
  key = var.index_key

  # Upload index.html to bucket or create a default one if file source is not specified
  source = var.index_source
  content = var.index_source == null ? var.index_content : null
  content_type = "text/html"

  depends_on = [ aws_s3_bucket.bucket ]
}