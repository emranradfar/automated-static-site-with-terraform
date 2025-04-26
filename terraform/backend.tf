# backend.tf

# This configuration sets up the backend for storing the Terraform state file in an S3 bucket.
# It defines the following settings:
# - **bucket**: The S3 bucket where the Terraform state file will be stored. (We'll Replace "addbucketnameherewhencreated" with the actual bucket name once created).
# - **key**: The path within the bucket to store the state file, ensuring that it is organized under "static-site/terraform.tfstate".
# - **region**: The AWS region where the S3 bucket is located. In this case, it's set to "us-east-1".
# - **encrypt**: Ensures that the Terraform state file is encrypted using AES-256 encryption to protect sensitive data in the state file.

terraform {
  backend "s3" {
    bucket = "emranradfar"
    key    = "static-site/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
