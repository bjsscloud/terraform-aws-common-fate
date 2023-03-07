locals {
  aws_sso_identity_store_arn = format(
    "arn:%s:identitystore::%s:identitystore/%s",
    var.aws_partition,
    var.aws_account_id,
    var.aws_sso_identity_store_id,
  )

  identity_configuration = jsonencode({
    "aws-sso" = {
      identityStoreRoleArn = var.identity_provider_type == "aws-sso" ? aws_iam_role.identity[0].arn : ""
      identityStoreId      = var.aws_sso_identity_store_id
      region               = var.aws_sso_region
      # externalId           = ""
    }

    "azure" = {
      tenantId        = var.azure_tenant_id
      clientId        = var.azure_client_id
      clientSecret    = "awsssm://${aws_ssm_parameter.secrets_identity_token.name}"
      emailIdentifier = var.azure_email_identifier
    }

    "okta" = {
      apiToken = "awsssm://${aws_ssm_parameter.secrets_identity_token.name}"
      orgUrl   = var.okta_org_url
    }
  })
}
