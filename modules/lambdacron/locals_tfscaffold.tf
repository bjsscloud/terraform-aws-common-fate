locals {
  # Compound Scope Identifier
  csi = replace(
    format(
      "%s-%s-%s-%s-%s",
      var.project,
      var.environment,
      var.component,
      var.module,
      var.function_name,
    ),
    "_",
    "",
  )

  # CSI for use in resources with an account namespace, eg IAM roles
  csi_account = replace(
    format(
      "%s-%s-%s-%s-%s-%s",
      var.project,
      var.environment,
      var.component,
      var.module,
      var.region,
      var.function_name,
    ),
    "_",
    "",
  )

  # CSI for use in resources with a unique namespace, i.e. S3 Buckets
  csi_global = replace(
    format(
      "%s-%s-%s-%s-%s-%s-%s",
      var.project,
      var.aws_account_id,
      var.region,
      var.environment,
      var.component,
      var.module,
      var.function_name,
    ),
    "_",
    "",
  )

  default_tags = merge(
    var.default_tags,
    {
      Module = var.module
      Name   = local.csi
    },
  )
}
