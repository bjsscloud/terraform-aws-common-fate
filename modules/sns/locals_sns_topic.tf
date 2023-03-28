locals {
  display_name              = var.display_name == null ? var.name : var.display_name
  sns_topic_policy_required = ( length(var.iam_policy_documents) > 0 || length(var.publishing_service_principals) > 0 )
}

