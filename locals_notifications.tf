locals {
  notifications_configuration = jsonencode({
    slack = {
      apiToken = "awsssm://${aws_ssm_parameter.secrets_notifications_slack_token.name}"
      slackIncomingWebhooks = {
        for k, v in var.slack_incoming_webhook_urls : k => { webhookUrl = "awsssm:///${var.ssm_parameter_prefix}/secrets/notifications/slackIncomingWebhooks/${k}/webhookUrl" }
      }
    }
  })
}
