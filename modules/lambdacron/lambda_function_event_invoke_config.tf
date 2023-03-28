resource "aws_lambda_function_event_invoke_config" "destination" {
  count = var.on_failure_sns_destination_enable ? 1 : 0

  function_name = aws_lambda_function.main.function_name

  destination_config {
    on_failure {
      destination = module.sns[0].topic["arn"]
    }
  }

  # This depends_on is used to to avoid race condition where lambda creation is attempted
  # prior to policy being attached to role, then failing as doesn't have permission to
  # write to SNS Topic
  depends_on = [
    aws_iam_role_policy_attachment.lambda_core,
  ]
}
