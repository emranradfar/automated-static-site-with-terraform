# variables.tf

variable "region" {
  description = "AWS region to deploy resources in"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  default     = "emranradfar"  # bucket name
}
