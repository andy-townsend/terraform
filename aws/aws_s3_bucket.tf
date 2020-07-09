resource "aws_s3_bucket" "s3-terraform-dev-state" {
  bucket = "terraform-dev-state"
  acl    = "private"
  region = "eu-west-2"
  tags = {
    Name        = "terraform-dev-state"
    owner       = "development"
  }
  
  versioning {
    enabled = true
    mfa_delete = false
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256" 
      }
    }
  }
}
