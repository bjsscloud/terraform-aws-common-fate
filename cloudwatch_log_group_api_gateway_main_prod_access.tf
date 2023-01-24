resource "aws_cloudwatch_log_group" "api_gateway_main_prod_access" {
  name              = "/aws/apigateway/${local.csi}/main/prod"
  retention_in_days = 30

  tags = merge(
    local.default_tags,
    {
      Name = "${local.csi}-api-gateway-main-prod-access"
    }
  )
}
