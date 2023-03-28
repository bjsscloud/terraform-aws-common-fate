resource "aws_cloudwatch_log_group" "api_gateway_governance_prod_execution" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.governance.id}/prod"
  retention_in_days = 365

  tags = merge(
    local.default_tags,
    {
      Name = "${local.csi}-api-gateway-governance-prod-execution"
    }
  )
}
