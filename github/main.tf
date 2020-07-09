
provider "github" {
  #token        = "${var.github_token}"  ## GITHUB_TOKEN (env var)
  organization = "andy-townsend"
}

terraform {
  backend "s3" {
    bucket = "terraform-state"
    key    = "github/tfstate"
    region = "eu-west-2"
  }
}


