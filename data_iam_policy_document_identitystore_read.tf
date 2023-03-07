data "aws_iam_policy_document" "identity_store_read" {
  count = var.identity_provider_type == "aws-sso" ? 1 : 0

  statement {
    sid    = "AllowReadIdentityStore"
    effect = "Allow"

    actions = [
      "identitystore:DescribeGroup",
      "identitystore:DescribeUser",
      "identitystore:ListGroupMembershipsForMember",
      "identitystore:ListGroups",
      "identitystore:ListUsers",
    ]

    resources = [
      "*",
    ]
  }
}

