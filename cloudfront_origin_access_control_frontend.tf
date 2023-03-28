resource "aws_cloudfront_origin_access_control" "frontend" {
  name                              = "${local.csi}-frontend"
  description                       = "${local.csi}-frontend"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
