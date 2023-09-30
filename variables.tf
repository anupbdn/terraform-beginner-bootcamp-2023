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