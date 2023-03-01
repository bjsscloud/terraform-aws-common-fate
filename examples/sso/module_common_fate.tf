module "common_fate" {
  count  = var.sso_common_fate["enabled"] ? 1 : 0
  source = "../../"

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }

  project        = var.project
  environment    = var.environment
  component      = var.component
  aws_account_id = var.aws_account_id
  region         = var.region

  aws_sso_identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]
  aws_sso_instance_arn      = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  aws_sso_region            = var.sso_region

  public_hosted_zone_id = var.public_hosted_zone_id

  administrator_group_id    = lookup(var.sso_common_fate, "administrator_group_id", "common_fate_administrators")
  azure_client_id           = lookup(var.sso_common_fate, "azure_client_id", "")
  azure_tenant_id           = lookup(var.sso_common_fate, "azure_tenant_id", "")
  azure_email_identifier    = lookup(var.sso_common_fate, "azure_email_identifier", "mail")
  identity_provider_name    = lookup(var.sso_common_fate, "identity_provider_name", null)
  identity_provider_type    = lookup(var.sso_common_fate, "identity_provider_type", "cognito")
  saml_sso_metadata_content = lookup(var.sso_common_fate, "saml_sso_metadata_content", null)
  saml_sso_metadata_url     = lookup(var.sso_common_fate, "saml_sso_metadata_url", null)
  sources_version           = lookup(var.sso_common_fate, "sources_version", null)

  web_cognito_custom_image_file   = lookup(var.sso_common_fate, "cognito_custom_image_file", null)
  web_cognito_custom_image_base64 = lookup(var.sso_common_fate, "cognito_custom_image_base64", null)

  default_tags = local.default_tags
}
