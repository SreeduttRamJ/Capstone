provider "aws" {

  region = "ap-south-1"

}



# Create IAM user

resource "aws_iam_user" "iam_user" {

  name = var.iam_user_name

}



# Attach inline S3 read-only policy to the user

resource "aws_iam_user_policy" "s3_read" {

  name   = "${var.iam_user_name}-s3-read-policy"

  user   = aws_iam_user.iam_user.name

  policy = var.s3_read_policy

}



# Create IAM access key for testing via CLI

resource "aws_iam_access_key" "user_keys" {

  user = aws_iam_user.iam_user.name

}
