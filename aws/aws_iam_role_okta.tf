
data "template_file" "role-okta-cross-account" {
  template = file("${path.module}/templates/role-okta-cross-account.json")
}

resource "aws_iam_role" "iam-role-okta-cross-account" {
  name               = "Okta-Idp-cross-account-role"
  assume_role_policy = file("${path.module}/templates/okta-iam-assume-role.json")
  tags = {
    description     = "Role used by Okta idp for cross account access"
    createdby       = "terraform"
  }
}

resource "aws_iam_role_policy" "iam-role-policy-okta-idp-cross-account" {
  name   = "policy-Okta-Idp-cross-account"
  role   = aws_iam_role.iam-role-okta-cross-account.name
  policy = data.template_file.role-okta-cross-account.rendered
}

