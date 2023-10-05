variable "user_uuid" {
  type        = string
  description = "A uuid variable"

  validation {
    condition     = can(regex("^([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$", var.user_uuid))
    error_message = "The input is not a valid UUID."
  }
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string

  validation {
    condition     = (
      length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 && 
      can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket_name))
    )
    error_message = "The bucket name must be between 3 and 63 characters, start and end with a lowercase letter or number, and can contain only lowercase letters, numbers, hyphens, and dots."
  }
}

variable "index_html_filepath"{
  description = "path where index.html file is placed"
  type = string

  # validation {
  #   condition     = fileexists(var.index_html_filepath)
  #   error_message = "The provided path for index.html does not exist."
  # }
}

variable "error_html_filepath"{
  description = "path where error.html file is placed"
  type = string

  # validation {
  #   condition     = fileexists(var.error_html_filepath)
  #   error_message = "The provided path for error.html does not exist."
  # }
 }