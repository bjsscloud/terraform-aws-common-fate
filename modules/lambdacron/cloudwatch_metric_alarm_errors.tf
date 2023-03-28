resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  count = var.cw_errors_notification["enable"] ? 1 : 0

  alarm_name                = "${local.csi}-errors"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.cw_errors_notification["evaluation_periods"]
  metric_name               = "Errors"
  namespace                 = "AWS/Lambda"
  period                    = var.cw_errors_notification["period"]
  statistic                 = var.cw_errors_notification["statistic"]
  threshold                 = var.cw_errors_notification["threshold"]
  alarm_actions             = [ module.sns[0].topic["arn"] ]
  alarm_description         = "Errors > 0 for Lambda ${local.csi}"
  insufficient_data_actions = []

  dimensions = {
    FunctionName = aws_lambda_function.main.function_name
  }
}
