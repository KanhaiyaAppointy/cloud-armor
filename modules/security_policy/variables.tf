variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The Google Cloud region"
  type        = string
}

variable "security_policy_name" {
  description = "Name of the Cloud Armor security policy"
  type        = string
}

variable "endpoints" {
  description = "List of endpoint paths to apply throttling to"
  type        = list(string)
}

variable "rate_limit_count" {
  description = "Number of requests allowed within the interval"
  type        = number
}

variable "rate_limit_interval" {
  description = "Time interval in seconds for the rate limit"
  type        = number
}

variable "preview_mode" {
  description = "Whether to enable preview mode for the security policy rules (test without enforcing)"
  type        = bool
}