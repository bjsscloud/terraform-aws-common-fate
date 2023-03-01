resource "aws_api_gateway_method" "main_api_v1_proxy_options" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.main_api_v1_proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
