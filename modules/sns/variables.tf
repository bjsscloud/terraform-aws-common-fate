##
# Basic Required Variables for tfscaffold Modules
##

##
# tfscaffold variables specific to this module
##

variable "aws_account_id" {
  type        = string
  description = "The AWS Account ID (AWS require this to be in the name of the Cloudwatch Log Group, so is optional if not configuring logging)"
  default     = null
}

variable "region" {
  type        = string
  description = "The AWS region (AWS require this to be in the name of the Cloudwatch Log Group, so is optional if not configuring logging)"
  default     = null
}

variable "module" {
  type        = string
  description = "The variable encapsulating the name of this module"
  default     = "sns"
}

variable "default_tags" {
  type        = map(string)
  description = "A map of default tags to apply to all taggable resources within the component"
  default     = {}
}

##
# Variables specific to this module
##

variable "content_based_deduplication" {
  type        = bool
  description = "Enables content-based deduplication for FIFO topics."
  default     = null
}

variable "delivery_policy" {
  type        = string
  description = "The SNS delivery policy"
  default     = null
}

variable "display_name" {
  type        = string
  description = "A custom display name for the topic. Defaults to the topic name when unset"
  default     = null
}

variable "fifo_topic" {
  type        = bool
  description = "Boolean indicating whether or not to create a FIFO (first-in-first-out) topic (default is false)."
  default     = false
}

variable "iam_policy_documents" {
  type        = list(string)
  description = "IAM Policy Documents to combine into the SNS Topic Policy, using the source_policies parameter"
  default     = []
}

variable "kms_master_key_id" {
  type        = string
  description = "KMS CMK for Message Encryption"
  default     = null
}

variable "log_retention_in_days" {
  type        = number
  description = "Log retention period in days for the feedback cloudwatch log group"
  default     = 365 # NIST
}

variable "name" {
  type        = string
  description = "The name of the SNS topic"
}

variable "publishing_service_principals" {
  type        = list(string)
  description = "A list of service principals to be granted SNS:Publish permission to the SNS topic, obviating the need to declare a whole topic policy document independently to permit it. e.g., [ codepipeline.amazonaws.com ]"
  default     = []
}

variable "signature_version" {
  type        = string
  description = "If SignatureVersion should be 1 (SHA1) or 2 (SHA256). The signature version corresponds to the hashing algorithm used while creating the signature of the notifications, subscription confirmations, or unsubscribe confirmation messages sent by Amazon SNS."
  default     = null
}

variable "tracing_config" {
  type        = string
  description = "Tracing mode of an Amazon SNS topic. Valid values: 'PassThrough', 'Active'."
  default     = null
}

##
# SNS Feedback (Delivery Status Logging)
##

# Defaults for Endpoints

variable "default_feedback_role_arn" {
  type        = string
  description = "Default Success/Failure Feedback Role ARN for all endpoints"
  default     = null
}

variable "default_failure_feedback_role_arn" {
  type        = string
  description = "Default Success/Failure Feedback Role ARN for all endpoints"
  default     = null
}

variable "default_success_feedback_role_arn" {
  type        = string
  description = "Default Success/Failure Feedback Role ARN for all endpoints"
  default     = null
}

variable "default_success_feedback_sample_rate" {
  type        = number
  description = "Default Success Feedback Sample Rate for all endpoints"
  default     = 100
}

# Application

variable "application_failure_feedback_role_arn" {
  type        = string
  description = "Role ARN for application endpoint delivery success"
  default     = null
}

variable "application_success_feedback_role_arn" {
  type        = string
  description = "Role ARN for application endpoint delivery success"
  default     = null
}

variable "application_success_feedback_sample_rate" {
  type        = string
  description = "Role ARN for application endpoint delivery success"
  default     = null
}

# Firehose

variable "firehose_failure_feedback_role_arn" {
  type        = string
  description = "Role ARN for firehose endpoint delivery success"
  default     = null
}

variable "firehose_success_feedback_role_arn" {
  type        = string
  description = "Role ARN for firehose endpoint delivery success"
  default     = null
}

variable "firehose_success_feedback_sample_rate" {
  type        = string
  description = "Role ARN for firehose endpoint delivery success"
  default     = null
}

# HTTP

variable "http_failure_feedback_role_arn" {
  type        = string
  description = "Role ARN for http endpoint delivery success"
  default     = null
}

variable "http_success_feedback_role_arn" {
  type        = string
  description = "Role ARN for http endpoint delivery success"
  default     = null
}

variable "http_success_feedback_sample_rate" {
  type        = string
  description = "Role ARN for http endpoint delivery success"
  default     = null
}

# Lambda

variable "lambda_failure_feedback_role_arn" {
  type        = string
  description = "Role ARN for lambda endpoint delivery success"
  default     = null
}

variable "lambda_success_feedback_role_arn" {
  type        = string
  description = "Role ARN for lambda endpoint delivery success"
  default     = null
}

variable "lambda_success_feedback_sample_rate" {
  type        = string
  description = "Role ARN for lambda endpoint delivery success"
  default     = null
}

# SQS

variable "sqs_failure_feedback_role_arn" {
  type        = string
  description = "Role ARN for sqs endpoint delivery success"
  default     = null
}

variable "sqs_success_feedback_role_arn" {
  type        = string
  description = "Role ARN for sqs endpoint delivery success"
  default     = null
}

variable "sqs_success_feedback_sample_rate" {
  type        = string
  description = "Role ARN for sqs endpoint delivery success"
  default     = null
}
