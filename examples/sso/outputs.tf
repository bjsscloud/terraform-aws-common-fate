output "common_fate" {
  description = "Common Fate"
  value       = var.sso_common_fate["enabled"] ? module.common_fate[0] : null
}
