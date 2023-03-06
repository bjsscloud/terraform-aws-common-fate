resource "aws_iam_role_policy" "identity_identity_store_read" {
  count = var.identity_provider_type == "aws-sso" ? 1 : 0

  name = "${local.csi}-identity"
  role = aws_iam_role.identity[0].id

  policy = data.aws_iam_policy_document.identity_store_read[0].json
}
