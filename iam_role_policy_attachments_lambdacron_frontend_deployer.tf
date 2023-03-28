resource "aws_iam_role_policy_attachment" "lambdacron_frontend_deployer_kms_s3_frontend_user" {
  role       = module.lambdacron_frontend_deployer.iam_role_name
  policy_arn = module.kms_s3_frontend.user_policy_arn
}
