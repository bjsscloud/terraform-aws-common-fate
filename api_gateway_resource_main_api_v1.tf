resource "aws_api_gateway_resource" "main_api_v1" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.main_api.id
  path_part   = "v1"
}
