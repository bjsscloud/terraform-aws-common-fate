resource "aws_cloudwatch_log_group" "waf_api_gateway" {
  count = var.waf["enabled"] ? 1 : 0

  # Mandatory WAF prefix
  name  = "aws-waf-logs-${local.csi}-api-gateway"

  retention_in_days = 731

  tags = merge(
    local.default_tags,
    {
      Name = "${local.csi}-waf-api-gateway"
    },
  )
}
