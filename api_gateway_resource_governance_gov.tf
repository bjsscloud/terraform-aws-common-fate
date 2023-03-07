resource "aws_api_gateway_resource" "governance_gov" {
  rest_api_id = aws_api_gateway_rest_api.governance.id
  parent_id   = aws_api_gateway_rest_api.governance.root_resource_id
  path_part   = "gov"
}
