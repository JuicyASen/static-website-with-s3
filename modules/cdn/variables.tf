variable "domain_name" {
  type = string
}

variable "s3_origin" {
  type = string
}

variable "whitelist_country" {
  type = list(string)
  default = ["AU"]
}