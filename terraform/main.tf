# main.tf

provider "aws" {
  region = "us-east-1"  # Choosing our region
}

resource "aws_s3_bucket" "static_site" {
  bucket = var.bucket_name #use variable for bucket name, good for reusabiltiy.

  website {
    index_document = "index.html"
    # Error document isn't needed here, simple website
    # error_document = "error.html"
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = var.bucket_name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${var.bucket_name}/*"
      }
    ]
  })
}

# Upload the index.html file to the bucket
resource "aws_s3_bucket_object" "index_html" {
  bucket = aws_s3_bucket.static_site.bucket
  key    = "index.html"
  source = "../site/index.html"  # Path to local index.html file
  acl    = "public-read"
}

# Allow public access by disabling public access blocks
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.static_site.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
