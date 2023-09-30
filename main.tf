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

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}

