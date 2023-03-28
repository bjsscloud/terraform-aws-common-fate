resource "aws_cloudwatch_log_group" "main" {
  # The local.csi is used instead of the function name
  # to avoid a dependency on the Lambda resource
  name = var.absolute_function_name ? "/aws/lambda/${var.function_name}" : "/aws/lambda/${local.csi}"

  retention_in_days = var.log_retention_in_days

  tags = merge(
    local.default_tags,
    {
      Name = local.csi
    },
  )
}
