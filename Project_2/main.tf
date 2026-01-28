

terraform {

  required_providers {

    aws = {

      source  = "hashicorp/aws"

      version = "~> 6.0"

    }

  }

}



provider "aws" {

  region = "ap-south-1" # change if needed

}



locals {

  bucket_name = "jp-s3-static-site-20260128" # <--- change to something globally-unique

}



resource "aws_s3_bucket" "site" {

  bucket        = local.bucket_name

  force_destroy = true



  tags = {

    Name        = "project2-s3-website"

    Environment = "dev"

  }

}



resource "aws_s3_bucket_website_configuration" "site" {

  bucket = aws_s3_bucket.site.id



  index_document {

    suffix = "index.html"

  }


}



resource "aws_s3_bucket_public_access_block" "site" {

  bucket = aws_s3_bucket.site.id



  block_public_acls       = true    # keep ACLs disabled

  ignore_public_acls      = true

  block_public_policy     = false   # allow a bucket policy that grants public read

  restrict_public_buckets = false

}



data "aws_iam_policy_document" "public_read" {

  statement {

    sid     = "PublicReadGetObject"

    effect  = "Allow"

    principals { 
      type = "*"
      identifiers = ["*"] 
    }

    actions = ["s3:GetObject"]

    resources = [

      "arn:aws:s3:::${local.bucket_name}/*"

    ]

  }

}



resource "aws_s3_bucket_policy" "public" {

  bucket = aws_s3_bucket.site.id

  policy = data.aws_iam_policy_document.public_read.json



  depends_on = [aws_s3_bucket_public_access_block.site]

}



resource "aws_s3_object" "index" {

  bucket       = aws_s3_bucket.site.id

  key          = "index.html"

  content_type = "text/html"

  source       = "${path.module}/index.html"

  etag         = filemd5("${path.module}/index.html")

}


