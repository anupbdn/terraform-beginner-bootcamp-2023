output "bucket_name" {
    value = aws_s3_bucket.website_bucket.bucket
}

output "website_endpoint" {
    value = aws_s3_bucket_website_configuration.static_website.website_endpoint  
}

# output "cdn_distribution" {
#     value = aws_cloudfront_distribution.s3_distribution.id  
# }

# output "cdn_domain_name" {
#   value = aws_cloudfront_distribution.s3_distribution.domain_name
# }