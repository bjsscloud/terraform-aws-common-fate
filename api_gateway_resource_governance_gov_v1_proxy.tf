resource "aws_api_gateway_resource" "governance_gov_v1_proxy" {
  rest_api_id = aws_api_gateway_rest_api.governance.id
  parent_id   = aws_api_gateway_resource.governance_gov_v1.id
  path_part   = "{proxy+}"
}
