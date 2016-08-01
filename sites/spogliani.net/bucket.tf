resource "aws_s3_bucket" "spogliani-net" {
  provider = "aws.private"

  bucket = "spogliani.net"
  acl    = "public-read"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicReadGetObject",
    "Effect": "Allow",
    "Principal": {
      "AWS": "*"
    },
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::spogliani.net/*"
  }]
}
EOF

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}
