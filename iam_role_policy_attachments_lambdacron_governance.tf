resource "aws_iam_role_policy_attachment" "lambdacron_governance_kms_api_pagination_user" {
  role       = module.lambdacron_governance.iam_role_name
  policy_arn = module.kms_api_pagination.user_policy_arn
}
