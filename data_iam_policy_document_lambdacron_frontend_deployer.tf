data "aws_iam_policy_document" "lambdacron_frontend_deployer" {
  statement {
    sid    = "AllowManageFrontendBucket"
    effect = "Allow"

    actions = [
      "s3:Abort*",
      "s3:DeleteObject*",
      "s3:GetBucket*",
      "s3:GetObject*",
      "s3:List*",
      "s3:PutObject",
      "s3:PutObjectLegalHold",
      "s3:PutObjectRetention",
      "s3:PutObjectTagging",
      "s3:PutObjectVersionTagging",
    ]

    resources = [
      module.s3bucket_frontend.arn,
      "${module.s3bucket_frontend.arn}/*",
    ]
  }

  statement {
    sid    = "AllowReadReleaseBucketObjects"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:GetObjectVersion",
    ]

    resources = [
      "arn:aws:s3:::${var.sources_s3_bucket_id}/*"
    ]
  }

  statement {
    sid    = "AllowListReleaseBucket"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.sources_s3_bucket_id}",
    ]
  }

  statement {
    sid    = "AllowCloudfrontInvalidation"
    effect = "Allow"

    actions = [
      "cloudfront:CreateInvalidation",
    ]

    resources = [
      aws_cloudfront_distribution.frontend.arn,
    ]
  }

  statement {
    sid    = "AllowCloudfrontGetInvalidation"
    effect = "Allow"

    actions = [
      "cloudfront:GetInvalidation",
    ]

    resources = [
      "*",
    ]
  }
}

