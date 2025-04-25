# main.tf

provider "aws" {
  region = "us-east-1"  # Choosing our region
}

resource "aws_s3_bucket" "static_site" {
  bucket = "addbucketnameherewhencreated"  # add bucket name

  website {
    index_document = "index.html"
    # Error document isn't needed here, simple website
    # error_document = "error.html"
  }
}

# Upload the index.html file to the bucket
resource "aws_s3_bucket_object" "index_html" {
  bucket = aws_s3_bucket.static_site.bucket
  key    = "index.html"
  source = "../site/index.html"  # Path to local index.html file
  acl    = "public-read"
}

# Apply the bucket policy using JSON file
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.static_site.bucket
  policy = file("../site/bucketpolicy.json")  # Load JSON policy
}

# Allow public access by disabling public access blocks
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.static_site.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
