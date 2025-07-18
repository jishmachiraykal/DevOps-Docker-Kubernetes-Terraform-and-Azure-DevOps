#declaring the provider to install pluggins for aws
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  # VERSION IS NOT NEEDED HERE
}

# Creating multiple iam users
resource "aws_iam_user" "my_users"{
    count = 2
    #first user will be created with my_user_1 and so on
    name = "my_user_${count.index}"
}