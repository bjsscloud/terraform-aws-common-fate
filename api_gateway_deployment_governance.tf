resource "aws_api_gateway_deployment" "governance" {
  description = "${local.csi}-governance"
  rest_api_id = aws_api_gateway_rest_api.governance.id

  lifecycle {
    create_before_destroy = true
  }

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_integration.governance_gov_v1_proxy_any,
      aws_api_gateway_method.governance_gov_v1_proxy_any,
      aws_api_gateway_resource.governance_gov,
      aws_api_gateway_resource.governance_gov_v1,
      aws_api_gateway_resource.governance_gov_v1_proxy,
      aws_api_gateway_rest_api.governance,
    ]))
  }

  depends_on = [
    aws_api_gateway_integration.governance_gov_v1_proxy_any,
    aws_api_gateway_method.governance_gov_v1_proxy_any,
    aws_api_gateway_resource.governance_gov,
    aws_api_gateway_resource.governance_gov_v1,
    aws_api_gateway_resource.governance_gov_v1_proxy,
  ]
}
