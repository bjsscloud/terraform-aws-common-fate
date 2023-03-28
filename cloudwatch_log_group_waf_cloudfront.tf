resource "aws_cloudwatch_log_group" "waf_cloudfront" {
  provider = aws.us-east-1

  count = var.waf["enabled"] ? 1 : 0

  # Mandatory WAF prefix
  name  = "aws-waf-logs-${local.csi}-cloudfront"

  retention_in_days = 731

  tags = merge(
    local.default_tags,
    {
      Name = "${local.csi}-waf-cloudfront"
    },
  )
}
