provider "aws" {
  region = var.sso_region
  alias  = "sso"

  allowed_account_ids = [
    var.aws_account_id,
  ]
}
