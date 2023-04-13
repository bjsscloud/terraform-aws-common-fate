resource "aws_ssm_parameter" "secrets_notifications_slack_webhook_urls" {
  for_each = nonsensitive(toset(keys(var.slack_incoming_webhook_urls)))
  name     = "/${var.ssm_parameter_prefix}/secrets/notifications/slackIncomingWebhooks/${each.key}/webhookUrl"
  type     = "SecureString"
  value    = var.slack_incoming_webhook_urls[each.key]
  key_id   = module.kms_ssm.key_arn

  lifecycle {
    ignore_changes = [
      value,
    ]
  }

  tags = merge(
    local.default_tags,
    {
      Name = "${local.csi}-secrets-notifications-slack-webhook-url-${each.key}",
    }
  )
}
