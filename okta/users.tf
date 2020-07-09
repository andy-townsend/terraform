resource "okta_user" "andy_townsend" {
  first_name                = "Andy"
  last_name                 = "Townsend"
  login                     = "me@andytownsend.co.uk"
  email                     = "me@andytownsend.co.uk"
  status                    = "ACTIVE"
  admin_roles               = ["SUPER_ADMIN"]
  user_type                 = "Deployed via Terraform"
  custom_profile_attributes = <<JSON
  {
    "vpnProfile": "platform_engineering"
  }
JSON

}