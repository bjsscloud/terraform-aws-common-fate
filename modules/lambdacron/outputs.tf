output "lambda_function_name" {
  value = aws_lambda_function.main.function_name
}

output "lambda_function_arn" {
  value = aws_lambda_function.main.arn
}

output "lambda_function_version" {
  value = aws_lambda_function.main.version
}

output "lambda_function_environment" {
  value = aws_lambda_function.main.environment
}

output "iam_role_name" {
  value = aws_iam_role.main.name
}

output "iam_role_arn" {
  value = aws_iam_role.main.arn
}

output "iam_role_policy_attachment_lambda_core" {
  value = aws_iam_role_policy_attachment.lambda_core
}

output "iam_role_policy_attachment_lambda_custom" {
  value = length(var.iam_policy_documents) == 0 ? null : aws_iam_role_policy_attachment.lambda_custom[0]
}

output "sns_topic_arn" {
  value = local.notifications_enable ? module.sns[0].topic["arn"] : null
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.main.name
}

output "lambda_function_invoke_arn" {
  value = aws_lambda_function.main.invoke_arn
}
