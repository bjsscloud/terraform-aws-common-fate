resource "aws_wafv2_web_acl_association" "api_gateway_access_handler_prod" {
  count = var.waf["enabled"] ? 1 : 0

  web_acl_arn  = aws_wafv2_web_acl.api_gateway[0].arn
  resource_arn = aws_api_gateway_stage.access_handler_prod.arn
}

resource "aws_wafv2_web_acl_association" "api_gateway_governance_prod" {
  count = var.waf["enabled"] ? 1 : 0

  web_acl_arn  = aws_wafv2_web_acl.api_gateway[0].arn
  resource_arn = aws_api_gateway_stage.governance_prod.arn
}

resource "aws_wafv2_web_acl_association" "api_gateway_main_prod" {
  count = var.waf["enabled"] ? 1 : 0

  web_acl_arn  = aws_wafv2_web_acl.api_gateway[0].arn
  resource_arn = aws_api_gateway_stage.main_prod.arn
}
