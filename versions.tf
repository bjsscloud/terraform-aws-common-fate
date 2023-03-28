terraform {
  required_providers {
    archive = {
      source = "hashicorp/archive"
    }

    aws = {
      source = "hashicorp/aws"

      configuration_aliases = [
        aws.us-east-1,
      ]
    }

    commonfate = {
      source = "common-fate/commonfate"
    }
  }

  required_version = ">= 1.1.0"
}
