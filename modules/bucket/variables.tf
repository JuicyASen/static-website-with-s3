variable "tags" {
  type = map(string)
}

variable "bucket_name" {
  type = string
}

variable "index_source" {
  type = string
  default = null
}

variable "index_key" {
  type = string
  default = "index.html" 
}

variable "index_content" {
  type = string
  default = <<EOT
  <!DOCTYPE html>
  <html>
  <head>
    <title>S3 Static Website</title>
  </head>

  <body>
    <h1>Welcome to my static Website</h1>
    <p>This is a html file reside in S3 bucket, behind the Cloud Front CDN. The whole infrastructure is provisioned by Terraform.</p>
    <p><a href="https://github.com/JuicyASen/static-website-with-s3">Checkout the source code</a> in my repository.</p>
  </body>
  EOT
}
