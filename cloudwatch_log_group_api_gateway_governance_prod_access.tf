resource "aws_cloudwatch_log_group" "api_gateway_governance_prod_access" {
  name              = "/aws/apigateway/${local.csi}/governance/prod"
  retention_in_days = 30

  tags = merge(
    local.default_tags,
    {
      Name = "${local.csi}-api-gateway-governance-prod-access"
    }
  )
}
