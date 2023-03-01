resource "aws_ssm_parameter" "secrets_identity_token" {
  name   = "/${var.ssm_parameter_prefix}/secrets/identity/token"
  type   = "SecureString"
  value  = var.identity_token_initial_secret_value
  key_id = module.kms_ssm.key_arn

  lifecycle {
    ignore_changes = [
      value,
    ]
  }

  tags = merge(
    local.default_tags,
    {
      Name = "${local.csi}-secrets-identity-token",
    }
  )
}
