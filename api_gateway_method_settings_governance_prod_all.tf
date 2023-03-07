resource "aws_api_gateway_method_settings" "governance_prod_all" {
  rest_api_id = aws_api_gateway_rest_api.governance.id
  stage_name  = aws_api_gateway_stage.governance_prod.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}
