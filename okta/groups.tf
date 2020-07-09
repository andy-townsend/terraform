resource "okta_group" "aws_access" {
  name        = "AWS_Access"
  description = "Deployed via Terraform - Group of users with access to AWS"
  users = [
    okta_user.andy_townsend.id
  ]
}