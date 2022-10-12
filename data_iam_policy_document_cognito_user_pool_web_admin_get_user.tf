data "aws_iam_policy_document" "cognito_user_pool_web_admin_get_user" {
  statement {
    sid    = "AllowGetCognitoAdminUser"
    effect = "Allow"

    actions = [
      "cognito-idp:AdminGetUser",
    ]

    resources = [
      aws_cognito_user_pool.web.arn,
    ]
  }
}

