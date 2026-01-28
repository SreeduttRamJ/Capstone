output "website_endpoint" {

  description = "Public website endpoint (HTTP)"

  value       = aws_s3_bucket_website_configuration.site.website_endpoint

}



output "bucket_name" {

  value = aws_s3_bucket.site.bucket

}
