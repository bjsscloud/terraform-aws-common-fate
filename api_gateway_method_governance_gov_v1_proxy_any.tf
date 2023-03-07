resource "aws_api_gateway_method" "governance_gov_v1_proxy_any" {
  rest_api_id   = aws_api_gateway_rest_api.governance.id
  resource_id   = aws_api_gateway_resource.governance_gov_v1_proxy.id
  http_method   = "ANY"
  authorization = "AWS_IAM"
}
