resource "aws_wafv2_web_acl" "api_gateway" {
  count = var.waf["enabled"] ? 1 : 0

  name        = "${local.csi}-api-gateway"
  description = "${local.csi}-api-gateway"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "BodySizeConstraint"
    priority = 0

    action {
      block {}
    }

    statement {
      size_constraint_statement {
        field_to_match  {
          body {
            oversize_handling = "CONTINUE"
          }
        }

        comparison_operator = "GT"
        size                = 16384

        text_transformation {
          priority = 0
          type     = "NONE"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "BodySizeConstraint"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSCommon"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "GenericRFI_QUERYARGUMENTS"
        }

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "SizeRestrictions_BODY"
        }

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "SizeRestrictions_QUERYSTRING"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${local.csi}-aws-common"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSKnownBadInputs"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${local.csi}-aws-known-bad-inputs"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AmazonIpReputationList"
    priority = 3

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${local.csi}-aws-amazon-ip-reputation"
      sampled_requests_enabled   = true
    }
  }

#  rule {
#    name     = "AmazonAnonymousIpList"
#    priority = 4
#
#    override_action {
#      none {}
#    }
#
#    statement {
#      managed_rule_group_statement {
#        name        = "AWSManagedRulesAnonymousIpList"
#        vendor_name = "AWS"
#      }
#    }
#
#    visibility_config {
#      cloudwatch_metrics_enabled = true
#      metric_name                = "${local.csi}-aws-anonymous-ip-list"
#      sampled_requests_enabled   = true
#    }
#  }

#  rule {
#    name     = "RateLimit"
#    priority = 5
#
#    action {
#      block {}
#    }
#
#    statement {
#      rate_based_statement {
#        limit              = 1000
#        aggregate_key_type = "IP"
#      }
#    }
#
#    visibility_config {
#      cloudwatch_metrics_enabled = true
#      metric_name                = "${local.csi}-rate-limit"
#      sampled_requests_enabled   = true
#    }
#  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${local.csi}-api-gateway"
    sampled_requests_enabled   = true
  }

  tags = merge(
    local.default_tags,
    {
      Name = "${local.csi}-api-gateway"
    }
  )
}
