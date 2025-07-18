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
variable "names"{
    type = list # type of the variable
    default = ["Ava","Serah","Mirah"]
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
    count = length(var.names)
    #first user will be created with my_user_1 and so on
    name = var.names[count.index]
    for_each=toset(var.names)
    name=each.value
}