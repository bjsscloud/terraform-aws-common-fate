resource "aws_api_gateway_resource" "main_webhook_v1_proxy" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.main_webhook_v1.id
  path_part   = "{proxy+}"
}
