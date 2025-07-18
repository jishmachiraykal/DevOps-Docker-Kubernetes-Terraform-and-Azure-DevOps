#declaring the provider to install pluggins for aws
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# declaring variable
variable "users"{
    type = map # type of the variable
    default = {
      Ava:"Netherlands,
      Serah:"Romania",
      Mirah:"Maldives"
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
    for_each=toset(var.users)
    # for each name key is the element, so using key
    name=each.key
    tags{
      country: each.value
    }
}