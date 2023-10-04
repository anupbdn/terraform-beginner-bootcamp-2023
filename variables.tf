variable "user_uuid" {
  type        = string
  description = "A uuid variable"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "index_html_filepath" {
  description = "Path of index.html"
  type = string  
}

variable "error_html_filepath" {
  description = "Path of error.html"
  type = string  
}

variable "content_version" {
  description = "The content version. Should be a positive integer starting at 1."
  type        = number
}

variable "assets_path" {
  description = "Path of assets"
  type = string  
}