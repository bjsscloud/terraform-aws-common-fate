data "aws_iam_policy_document" "assumerole_identity" {
  statement {
    sid    = "AllowPrincipalsAssumeRoleForIdentityRole"
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"

      identifiers = [
        module.lambdacron_api.iam_role_arn,
        module.lambdacron_idp_sync.iam_role_arn,
      ]
    }
  }
}
