variable "iam_user_name" {

  description = "IAM user name"

  type        = string

  default     = "project4-user"

}



# S3 read-only policy stored as a raw JSON string (HEREDOC).

# Now includes ListAllMyBuckets to list all buckets in the account.

variable "s3_read_policy" {

  description = "IAM Policy allowing S3 read and list-all-buckets"

  type        = string

  default     = <<POLICY

{

  "Version": "2012-10-17",

  "Statement": [

    {

      "Sid": "BucketAndObjectRead",

      "Effect": "Allow",

      "Action": [

        "s3:GetObject",

        "s3:ListBucket"

      ],

      "Resource": [

        "arn:aws:s3:::*",

        "arn:aws:s3:::*/*"

      ]

    },

    {

      "Sid": "ListAllMyBuckets",

      "Effect": "Allow",

      "Action": "s3:ListAllMyBuckets",

      "Resource": "*"

    }

  ]

}

POLICY

}
