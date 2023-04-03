provider "aws" {
  region  = "ap-south-1" # Don't change the region
}

# Add your S3 backend configuration here

terraform {
  backend "s3" {
    bucket         = "3.devops.candidate.exam"
    key            = "abhijeet.nikam"
    region         = "ap-south-1"
    encrypt        = true
 //   dynamodb_table = "terraform-lock"
  
  }
}

