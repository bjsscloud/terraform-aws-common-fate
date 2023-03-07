resource "aws_api_gateway_resource" "governance_gov_v1" {
  rest_api_id = aws_api_gateway_rest_api.governance.id
  parent_id   = aws_api_gateway_resource.governance_gov.id
  path_part   = "v1"
}
