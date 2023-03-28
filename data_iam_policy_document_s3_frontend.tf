data "aws_iam_policy_document" "s3_frontend" {
  statement {
    sid    = "AllowCloudfrontOacGetObject"
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${module.s3bucket_frontend.arn}/*",
    ]

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
