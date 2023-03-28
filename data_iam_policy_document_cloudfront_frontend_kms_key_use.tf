data "aws_iam_policy_document" "cloudfront_frontend_kms_key_use" {
  statement {
    sid    = "AllowCloudFrontFrontendToUseTheKey"
    effect = "Allow"

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:GenerateDataKeyPair",
      "kms:GenerateDataKeyPairWithoutPlaintext",
      "kms:GenerateDataKeyWithoutPlaintext",
    ]

    resources = [
      "*",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${var.aws_account_id}:root",
      ]
    }

    principals {
      type = "Service"

      identifiers = [
        "cloudfront.${var.aws_url_suffix}",
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [
        aws_cloudfront_distribution.frontend.arn,
      ]
    }
  }
}
