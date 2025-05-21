variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "Region for resource deployment"
}

variable "security_policy_name" {
  type        = string
  description = "Unique name for the security policy"
}

variable "endpoints" {
  type        = list(string)
  description = "List of endpoints to apply rate limiting on"
}

variable "rate_limit_count" {
  type        = number
  description = "Number of allowed requests"
}

variable "rate_limit_interval" {
  type        = number
  description = "Interval in seconds"
}

variable "preview_mode" {
  type        = bool
  description = "Enable preview mode"
}