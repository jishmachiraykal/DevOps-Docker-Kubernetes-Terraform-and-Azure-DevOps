resource "aws_s3_bucket" "my_s3_bucket"{
    # name of the bucket that needs to be created. Underscore(_) is not allowed and name should be unique globally
    bucket="my_s3_bucket_jish"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# creating AWS IAM using terraform
resource "aws_iam_user" "my_user"{
    name = "my_user_kiya"
}