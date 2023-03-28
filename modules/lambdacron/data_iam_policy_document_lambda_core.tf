data "aws_iam_policy_document" "lambda_core" {
  statement {
    sid    = "AllowLogging"
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "${aws_cloudwatch_log_group.main.arn}:*",
    ]
  }

  statement {
    sid    = "AllowXRay"
    effect = "Allow"

    actions = [
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
    ]

    resources = [
      "*",
    ]
  }

  dynamic "statement" {
    for_each = var.insights_enable ? [1] : []

    content {
      sid    = "AllowInsightsLogging"
      effect = "Allow"

      actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]

      resources = [
        "arn:aws:logs:${var.region}:${var.aws_account_id}:log-group:/aws/lambda-insights:*",
      ]
    }
  }

  dynamic "statement" {
    for_each = local.notifications_enable ? [1] : []

    content {
      sid    = "AllowLambdaToPublishToTopic"
      effect = "Allow"

      actions = [
        "sns:Publish",
      ]

      resources = [
        module.sns[0].topic["arn"],
      ]
    }
  }

  dynamic "statement" {
    for_each = local.notifications_enable ? [1] : []

    content {
      sid    = "AllowEncryptedSnsActions"
      effect = "Allow"

      actions = [
        "kms:Decrypt",
        "kms:GenerateDataKey",
      ]

      resources = [
        module.kms.key_arn,
      ]
    }
  }
}
