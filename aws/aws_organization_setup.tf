resource "aws_organizations_organization" "my_org" {
  aws_service_access_principals = ["config-multiaccountsetup.amazonaws.com"]
  feature_set                   = "ALL"
}

resource "aws_config_organization_managed_rule" "root_mfa_enabled" {
  depends_on = ["aws_organizations_organization.my_org"]

  name            = "root_mfa_enabled"
  rule_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  description     = "Ensure MFA is enabled on all Root Accounts."
} 
