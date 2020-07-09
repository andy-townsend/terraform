# Create AWS IAM SAML Provider for Okta
resource "aws_iam_saml_provider" "okta-saml-provider" {
  name                   = "oktaSSO"
  saml_metadata_document = file("data/metadata.xml")
}
