resource "aws_s3_bucket" "trecamini-net" {
  provider = "aws.private"

  bucket = "trecamini.net"
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
    "Resource": "arn:aws:s3:::trecamini.net/*"
  }]
}
EOF

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

resource "aws_s3_bucket" "www-trecamini-net" {
  provider = "aws.private"

  bucket = "www.trecamini.net"
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
    "Resource": "arn:aws:s3:::www.trecamini.net/*"
  }]
}
EOF

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}
