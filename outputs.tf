output "bucket_name" {
    value = module.terrahouse_aws.bucket_name
    description = "Bucket name for our static website"
}

output "website_endpoint" {
    value = module.terrahouse_aws.website_endpoint  
}

# output "cdn_distribution" {
#     value = module.terrahouse_aws.cdn_distribution  
# }

# output "cdn_domain_name" {
#   value = module.terrahouse_aws.cdn_domain_name
# }