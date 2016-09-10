resource "aws_iam_user" "trecamini-net-upload" {
  provider = "aws.private"
  name = "trecamini-net-upload"
  path = "/sites/"
}

resource "aws_iam_access_key" "trecamini-net-upload" {
  provider = "aws.private"
  user = "${aws_iam_user.trecamini-net-upload.name}"
}

resource "aws_iam_user_policy" "trecamini-net-upload" {
  provider = "aws.private"
  name = "ReadWriteAccessToSpoglianiNetBucket"
  user = "${aws_iam_user.trecamini-net-upload.name}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Action": [
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ],
    "Effect": "Allow",
    "Resource": [
      "${aws_s3_bucket.trecamini-net.arn}",
      "${aws_s3_bucket.www-trecamini-net.arn}"
    ]
  }, {
    "Action": [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject"
    ],
    "Effect": "Allow",
    "Resource": [
      "${aws_s3_bucket.trecamini-net.arn}/*",
      "${aws_s3_bucket.www-trecamini-net.arn}/*"
    ]
  }]
}
EOF
}
