resource "aws_api_gateway_deployment" "main" {
  description = "${local.csi}-main"
  rest_api_id = aws_api_gateway_rest_api.main.id

  lifecycle {
    create_before_destroy = true
  }

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_authorizer.main,
      aws_api_gateway_integration.main_api_v1_proxy_any,
      aws_api_gateway_integration.main_api_v1_proxy_options,
      aws_api_gateway_integration.main_webhook_v1_proxy_any,
      aws_api_gateway_integration_response.main_api_v1_proxy_options_200,
      aws_api_gateway_method.main_api_v1_proxy_any,
      aws_api_gateway_method.main_api_v1_proxy_options,
      aws_api_gateway_method.main_webhook_v1_proxy_any,
      aws_api_gateway_method_response.main_api_v1_proxy_any_200,
      aws_api_gateway_method_response.main_api_v1_proxy_options_200,
      aws_api_gateway_resource.main_api,
      aws_api_gateway_resource.main_api_v1,
      aws_api_gateway_resource.main_api_v1_proxy,
      aws_api_gateway_resource.main_webhook,
      aws_api_gateway_resource.main_webhook_v1,
      aws_api_gateway_resource.main_webhook_v1_proxy,
      aws_api_gateway_rest_api.main,
    ]))
  }

  depends_on = [
    aws_api_gateway_integration.main_api_v1_proxy_any,
    aws_api_gateway_integration.main_api_v1_proxy_options,
    aws_api_gateway_integration.main_webhook_v1_proxy_any,
    aws_api_gateway_integration_response.main_api_v1_proxy_options_200,
    aws_api_gateway_method.main_api_v1_proxy_any,
    aws_api_gateway_method.main_api_v1_proxy_options,
    aws_api_gateway_method.main_webhook_v1_proxy_any,
    aws_api_gateway_method_response.main_api_v1_proxy_options_200,
    aws_api_gateway_resource.main_api,
    aws_api_gateway_resource.main_api_v1,
    aws_api_gateway_resource.main_api_v1_proxy,
    aws_api_gateway_resource.main_webhook,
    aws_api_gateway_resource.main_webhook_v1,
    aws_api_gateway_resource.main_webhook_v1_proxy,
  ]
}
