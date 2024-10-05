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
    <title>YC JR Index</title>
  </head>

  <body>

    <h1>Welcome to S3 static Website</h1>
    <p>This is a html file reside in S3 bucket</p>

  </body>
  <footer>
    This is footer
  </footer>
  EOT
}
