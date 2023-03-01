resource "aws_api_gateway_method" "main_webhook_v1_proxy_any" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.main_webhook_v1_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}
