resource "aws_wafv2_web_acl_logging_configuration" "api_gateway" {
  count = var.waf["enabled"] ? 1 : 0

  log_destination_configs = [
    aws_cloudwatch_log_group.waf_api_gateway[0].arn,
  ]

  resource_arn = aws_wafv2_web_acl.api_gateway[0].arn
}
