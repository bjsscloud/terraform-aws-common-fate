resource "aws_cloudwatch_log_group" "main" {
  name = format(
    "sns/%s/%s/%s",
    var.region,
    var.aws_account_id,
    var.name,
  )

  retention_in_days = var.log_retention_in_days

  tags = merge(
    local.default_tags,
    {
      Name = var.name
    },
  )
}
