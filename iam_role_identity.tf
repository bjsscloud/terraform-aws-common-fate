resource "aws_iam_role" "identity" {
  count = var.identity_provider_type == "aws-sso" ? 1 : 0

  name               = "${local.csi}-identity"
  assume_role_policy = data.aws_iam_policy_document.assumerole_identity.json

  tags = merge(
    local.default_tags,
    {
      "Name"                  = "${local.csi}-identity"
      "common-fate-abac-role" = "aws-sso-identity-provider" # TODO: Check if actually required
    }
  )

  provisioner "local-exec" {
    command = "sleep 10"
  }
}
