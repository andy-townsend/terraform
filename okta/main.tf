provider "okta" {
  org_name = "andy-townsend"
  base_url = "okta.com"
}

terraform {
  backend "s3" {
    bucket = "terraform-state"
    key    = "okta/tfstate"
    region = "eu-west-2"
  }
}
