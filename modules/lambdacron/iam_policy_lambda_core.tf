resource "aws_iam_policy" "lambda_core" {
  name        = "${local.csi_account}-lambda-core"
  description = "Core execution policy for ${var.function_name} Lambda"
  policy      = data.aws_iam_policy_document.lambda_core.json
}
