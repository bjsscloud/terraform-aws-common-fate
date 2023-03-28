resource "aws_cloudfront_monitoring_subscription" "frontend" {
  distribution_id = aws_cloudfront_distribution.frontend.id

  monitoring_subscription {
    realtime_metrics_subscription_config {
      realtime_metrics_subscription_status = "Enabled"
    }
  }
}
