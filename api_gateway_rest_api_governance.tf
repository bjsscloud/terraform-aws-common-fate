resource "aws_api_gateway_rest_api" "governance" {
  name = "${local.csi}-governance"

  tags = merge(
    local.default_tags,
    {
      Name = "${local.csi}-governance",
    }
  )
}
