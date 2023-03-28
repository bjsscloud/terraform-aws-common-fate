data "aws_cloudfront_cache_policy" "frontend" {
  # Was originally hardcoded to:
  # "b2884449-e4de-46a7-ac36-70bc7f1ddd6d" / CachingOptimizedForUncompressedObjects
  name = var.frontend_cloudfront_cache_policy
}
