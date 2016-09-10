resource "aws_s3_bucket" "flaviopogliani-net" {
  provider = "aws.private"

  bucket = "flaviopogliani.net"
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
    "Resource": "arn:aws:s3:::flaviopogliani.net/*"
  }]
}
EOF

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

resource "aws_s3_bucket" "www-flaviopogliani-net" {
  provider = "aws.private"

  bucket = "www.flaviopogliani.net"
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
    "Resource": "arn:aws:s3:::www.flaviopogliani.net/*"
  }]
}
EOF

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}
