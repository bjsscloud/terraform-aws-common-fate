resource "aws_cloudfront_distribution" "frontend" {
  enabled = "true"
  comment = "${local.csi}-frontend"

  aliases = var.public_hosted_zone_id == null ? [] : [ local.frontend_domain_custom_value ]

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }

  default_cache_behavior {
    allowed_methods = [
      "GET",
      "HEAD",
    ]

    cache_policy_id = data.aws_cloudfront_cache_policy.frontend.id

    cached_methods = [
      "GET",
      "HEAD",
    ]

    compress = false

    target_origin_id = "${local.csi}-frontend"

    viewer_protocol_policy = "redirect-to-https"

    #min_ttl                = "0"
    #default_ttl            = "3600"
    #max_ttl                = "3600"
  }

  default_root_object = "/index.html"
  http_version        = "http2and3"
  is_ipv6_enabled     = true

  logging_config {
    bucket          = module.s3bucket_cloudfront_logs.bucket_regional_domain_name
    include_cookies = true
  }

  origin {
    domain_name              = module.s3bucket_frontend.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.frontend.id
    origin_id                = "${local.csi}-frontend"
    origin_path              = "/${local.frontend_assets_key_prefix}"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  dynamic "viewer_certificate" {
    for_each = var.public_hosted_zone_id == null ? [] : [1]

    content {
      acm_certificate_arn      = aws_acm_certificate.frontend[0].arn
      minimum_protocol_version = "TLSv1.2_2021"
      ssl_support_method       = "sni-only"
    }
  }

  dynamic "viewer_certificate" {
    for_each = var.public_hosted_zone_id == null ? [1] : []

    content {
      cloudfront_default_certificate = true
    }
  }

  web_acl_id = var.waf["enabled"] ? aws_wafv2_web_acl.cloudfront[0].arn : null

  tags = merge(
    local.default_tags,
    {
      Name = "${local.csi}-frontend",
    }
  )

  depends_on = [
    aws_acm_certificate_validation.frontend,
    module.s3bucket_cloudfront_logs,
  ]
}
