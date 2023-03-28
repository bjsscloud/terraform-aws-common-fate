module "lambdacron_cache_sync" {
  source = "./modules/lambdacron"

  project        = var.project
  environment    = var.environment
  component      = var.component
  aws_account_id = var.aws_account_id
  region         = var.region
  aws_partition  = var.aws_partition
  aws_url_suffix = var.aws_url_suffix

  function_name         = "${var.module}-cache-sync"
  description           = "${local.csi} Cache Synchronisation"
  memory                = 128
  runtime               = "go1.x"
  timeout               = 300
  log_retention_in_days = var.lambda_function_log_retention_in_days

  iam_policy_documents = [
    data.aws_iam_policy_document.cognito_user_pool_web_manage.json,
    data.aws_iam_policy_document.dynamodb_table_use.json,
    data.aws_iam_policy_document.parameter_store_secrets_identity_read.json,
    data.aws_iam_policy_document.rest_api_access_handler_invoke.json,
  ]

  schedule = var.cache_sync_schedule

  function_source_type      = "s3"
  function_source_s3_bucket = jsondecode(aws_lambda_invocation.frontend_deployer.result)["functionBucket"]
  function_source_s3_key    = jsondecode(aws_lambda_invocation.frontend_deployer.result)["functionArchives"]["cache-sync"]

  handler_function_name = "cache-sync"

  lambda_env_vars = {
    COMMONFATE_ACCESS_HANDLER_URL = local.access_handler_api_url
    COMMONFATE_TABLE_NAME         = aws_dynamodb_table.main.name
  }

  sns_logs = var.sns_logs

  subscription_arns = var.lambda_dlq_targets

  insights_enable = true

  default_tags = local.default_tags
}

