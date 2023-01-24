resource "aws_api_gateway_rest_api" "main" {
  name = "${local.csi}-main"

  tags = merge(
    local.default_tags,
    {
      Name = "${local.csi}-main",
    }
  )
}
