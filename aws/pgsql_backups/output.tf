output "bucket_arn" {
  value = "${aws_s3_bucket.pgsql-backups-bucket.arn}"
  description = "The ARN of the S3 bucket where pgsql backups will be stored."
}

output "bucket_id" {
  value = "${aws_s3_bucket.pgsql-backups-bucket.id}"
  description = "The ID of the S3 bucket where pgsql backups will be stored."
}

output "group_id" {
  value = "${aws_iam_group.pgsql-backups-group.id}"
  description = "The ID of the IAM group with write access to the S3 bucket where pgsql backups will be stored."
}

