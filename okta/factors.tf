resource "okta_factor" "okta_verify" {
  provider_id = "okta_otp"
  active      = "true"
}

resource "okta_factor" "google_auth" {
  provider_id = "google_otp"
  active      = "true"
} 