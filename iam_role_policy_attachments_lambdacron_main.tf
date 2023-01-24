resource "aws_iam_role_policy_attachment" "lambdacron_api_kms_api_pagination_user" {
  role       = module.lambdacron_api.iam_role_name
  policy_arn = module.kms_api_pagination.user_policy_arn
}
