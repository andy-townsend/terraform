variable "customer" {
  type = "string"
  description = "The identifier of the customer."
}

variable "cluster_name" {
  type = "string"
  description = "The name of the cluster."
}

variable "cluster_namespace" {
  type = "string"
  description = "The namespace in the cluster."
}

variable "pgsql_backups_retention_days" {
  type = "string"
  description = "The number of days to retain PG backups in S3."
}

variable "pgsql_backups_iam_user" {
  type = "string"
  description = "The IAM username to create for running backups."
}
