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
   // role_arn       = "arn:aws:iam::<AWS_ACCOUNT_ID_OF_BACKEND>:role/terraform-backend"
  }
}
