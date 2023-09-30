#terraform {
#  cloud {
#    organization = "anupbdn"
#
#    workspaces {
#      name = "terra-house-1"
#    }
#  }
#  required_providers {
#    random = {
#      source = "hashicorp/random"
#      version = "3.5.1"
#    }
#    aws = {
#      source = "hashicorp/aws"
#      version = "5.18.1"
#    }
#  }
#}
#
#
#provider "aws" { }
#
#provider "random" {
#  # Configuration options
#}
#
##https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
#
# resource "random_string" "bucket_name" {
#   length           = 32
#   special          = false
#   override_special = ""
#   lower            = true
#   upper            = false
# }



#https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html

resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
  
  tags = {
    UserUuid = var.user_uuid   
  }
}

# import {
#   to = aws_s3_bucket.bucket
#   id = "dd5q15upt905kqoarzp9v0mgx95xwsyi"
# }

