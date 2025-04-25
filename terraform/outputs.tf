# outputs.tf

output "bucket_name" {
  value = aws_s3_bucket.static_site.bucket
}

output "website_url" {
  value = aws_s3_bucket.static_site.website_endpoint
}
