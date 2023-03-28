module "sns" {
  count  = local.notifications_enable ? 1 : 0
  source = "../../modules/sns"

  aws_account_id    = var.aws_account_id
  kms_master_key_id = module.kms.key_arn
  name              = local.csi
  region            = var.region

  default_feedback_role_arn            = var.sns_logs["iam_role_arn"]
  default_success_feedback_sample_rate = coalesce(var.sns_logs["success_sample_rate"], 100)

  iam_policy_documents = [
    data.aws_iam_policy_document.sns.json,
  ]

  default_tags = local.default_tags
}
