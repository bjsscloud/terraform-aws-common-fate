resource "aws_wafv2_web_acl_logging_configuration" "cloudfront" {
  provider = aws.us-east-1

  count = var.waf["enabled"] ? 1 : 0

  log_destination_configs = [
    aws_cloudwatch_log_group.waf_cloudfront[0].arn,
  ]

  resource_arn = aws_wafv2_web_acl.cloudfront[0].arn
}
