terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}


provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}

#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string

resource "random_string" "bucket_name" {
  length           = 32
  special          = false
  override_special = ""
  lower            = true
  upper            = false
}

output "random_bucket_name" {
    value = random_string.bucket_name.result
}

#https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result
}

