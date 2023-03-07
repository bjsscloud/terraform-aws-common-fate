module "lambdacron_governance" {
  source = "./modules/lambdacron"

  project        = var.project
  environment    = var.environment
  component      = var.component
  aws_account_id = var.aws_account_id
  region         = var.region
  aws_partition  = var.aws_partition
  aws_url_suffix = var.aws_url_suffix

  function_name         = "${var.module}-governance"
  description           = "${local.csi} Governance API"
  memory                = 128
  runtime               = "go1.x"
  timeout               = 60
  log_retention_in_days = var.lambda_function_log_retention_in_days

  allowed_triggers = {
    ApiGatewayGovernanceApi = {
      service = "apigateway"

      source_arn = format(
        "arn:%s:execute-api:%s:%s:%s/%s/*/gov/v1/*",
        var.aws_partition,
        var.region,
        var.aws_account_id,
        aws_api_gateway_rest_api.governance.id,
        "prod",
      )
    }
  }

  iam_policy_documents = [
    data.aws_iam_policy_document.dynamodb_table_use.json,
    data.aws_iam_policy_document.rest_api_access_handler_invoke.json,
  ]

  function_source_type      = "s3"
  function_source_s3_bucket = jsondecode(aws_lambda_invocation.frontend_deployer.result)["functionBucket"]
  function_source_s3_key    = jsondecode(aws_lambda_invocation.frontend_deployer.result)["functionArchives"]["governance"]

  handler_function_name = "governance"

  lambda_env_vars = {
    COMMONFATE_TABLE_NAME             = aws_dynamodb_table.main.name
    COMMONFATE_MOCK_ACCESS_HANDLER    = false
    COMMONFATE_ACCESS_HANDLER_URL     = local.access_handler_api_url
    COMMONFATE_PROVIDER_CONFIG        = local.common_fate_provider_configuration
    COMMONFATE_PAGINATION_KMS_KEY_ARN = module.kms_api_pagination.key_arn
  }

  subscription_arns = var.lambda_dlq_targets

  use_lambda_insights = true

  default_tags = local.default_tags
}
