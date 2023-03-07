resource "aws_api_gateway_integration" "governance_gov_v1_proxy_any" {
  rest_api_id = aws_api_gateway_rest_api.governance.id
  resource_id = aws_api_gateway_resource.governance_gov_v1_proxy.id
  http_method = aws_api_gateway_method.governance_gov_v1_proxy_any.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"

  uri = format(
    "arn:%s:apigateway:%s:lambda:path/2015-03-31/functions/%s/invocations",
    var.aws_partition,
    var.region,
    module.lambdacron_governance.lambda_function_arn,
  )
}
