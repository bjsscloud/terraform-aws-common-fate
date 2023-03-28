locals {
  default_tags = merge(
    var.default_tags,
    {
      Module = var.module
      Name   = var.name
    },
  )
}
