## This module performs the following;
## 
## 1. Create an S3 bucket for pgsql backups
## 2. Block public access to the created bucket
## 3. Create an IAM policy to restrict access to the created bucket
## 4. Create an IAM group 
## 5. Attach the IAM policy to the created group
## 6. Create an IAM user account for the pgsql backups
## 7. Add the IAM user to the group that allows access to the S3 bucket.
##
## Things to note: 
## - Need to manually create the access keys in the AWS Console for the user account.


## The bucket where pgsql backups for an environment are stored
resource "aws_s3_bucket" "pgsql-backups-bucket" {
  bucket = "pgsql-backups-${var.cluster_name}-${var.cluster_namespace}"

  tags {
    Name = "pgsql backups for ${var.cluster_namespace} namespace in cluster ${var.cluster_name}"
  }

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  lifecycle_rule {
    id      = "Pgsql backups bucket lifecycle"
    enabled = true
    abort_incomplete_multipart_upload_days = 2

    expiration {
      days = "${var.pgsql_backups_retention_days}"
    }
    noncurrent_version_expiration {
      days = "${var.pgsql_backups_retention_days}"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

}

## Avoid public policies / ACLs set by mistake
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = "${aws_s3_bucket.pgsql-backups-bucket.id}"

  block_public_policy     = true
  block_public_acls       = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

## The policy that gives write access to the bucket where pgsql dumps will be backed up.
resource "aws_iam_policy" "pgsql-backups-policy" {
  name = "${var.cluster_name}-pgsql-backups-${var.cluster_namespace}"
  description = "Allows to write to the pgsql backups bucket for the ${var.cluster_namespace} namespace on cluster ${var.cluster_name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.pgsql-backups-bucket.arn}"
    },
    {
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:AbortMultipartUpload",
        "s3:ListMultipartUploadParts"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.pgsql-backups-bucket.arn}/*"
    }
  ]
}
EOF
}

## The group that grants access to the backups bucket.
resource "aws_iam_group" "pgsql-backups-group" {
  name = "${var.customer}-${var.cluster_namespace}-pqsql-group"
}

## Attach the IAM policy to the group
resource "aws_iam_group_policy_attachment" "attach_runner_policy" {
  group = "${aws_iam_group.pgsql-backups-group.name}"
  policy_arn = "${aws_iam_policy.pgsql-backups-policy.arn}"
}

## Create the IAM user account
resource "aws_iam_user" "pgsql-backup-account" {
  name = "${var.customer}-${var.cluster_namespace}-pgsql-backup-account"
}

## Add the user to the pgsql-backups-group
resource "aws_iam_user_group_membership" "pgsql-backups-group-membership" {
  user = "${aws_iam_user.pgsql-backup-account.name}"

  groups = [
    "${aws_iam_group.pgsql-backups-group.name}"
  ]
}