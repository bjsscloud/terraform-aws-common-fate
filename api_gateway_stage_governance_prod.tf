resource "aws_api_gateway_stage" "governance_prod" {
  deployment_id = aws_api_gateway_deployment.governance.id
  rest_api_id   = aws_api_gateway_rest_api.governance.id
  stage_name    = "prod"

  xray_tracing_enabled = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_governance_prod_access.arn

    format = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"
  }

  depends_on = [
    aws_api_gateway_account.main,
  ]
}
