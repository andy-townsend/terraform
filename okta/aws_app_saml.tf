resource "okta_app_saml" "aws_console" {
  label                      = "AWS Console"
  status                     = "ACTIVE"
  accessibility_self_service = false
  assertion_signed           = false
  auto_submit_toolbar        = true
  preconfigured_app          = "amazon_aws"
  response_signed            = false
  user_name_template         = "$${source.login}"
  user_name_template_type    = "BUILT_IN"
  app_settings_json = jsonencode(
    {
      appFilter           = "okta"
      awsEnvironmentType  = "aws.amazon"
      groupFilter         = "aws_(?{{accountid}}\\d+)_(?{{role}}[a-zA-Z0-9+=,.@\\-_]+)"
      identityProviderArn = "arn:aws:iam::1234567890:saml-provider/oktaSSO"
      joinAllRoles        = false
      loginURL            = "https://console.aws.amazon.com/ec2/home"
      roleValuePattern    = "arn:aws:iam::$${accountid}:saml-provider/OKTA,arn:aws:iam::$${accountid}:role/$${role}"
      sessionDuration     = 3600
      useGroupMapping     = false
    }
  )
  hide_ios          = true
  hide_web          = false
  honor_force_authn = false

  features = ["PUSH_NEW_USERS", "PUSH_PROFILE_UPDATES"]
  groups = [
    data.okta_group.aws_access.id,
  ]

}
