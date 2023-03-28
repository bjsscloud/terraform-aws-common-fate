module "kms_s3_frontend" {
  source = "./modules/kms"

  project        = var.project
  environment    = var.environment
  component      = var.component
  aws_account_id = var.aws_account_id
  region         = var.region
  aws_partition  = var.aws_partition
  aws_url_suffix = var.aws_url_suffix

  alias           = "alias/s3/${local.csi}-frontend"
  deletion_window = "30"

  key_policy_documents = [
    data.aws_iam_policy_document.cloudfront_frontend_kms_key_use.json,
  ]

  name = "${var.module}-s3-frontend"

  default_tags = local.default_tags
}

