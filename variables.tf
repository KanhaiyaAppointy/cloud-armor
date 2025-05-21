variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The Google Cloud region"
  type        = string
  default     = "us-central1"
}

variable "default_preview_mode" {
  description = "Default preview mode setting for all policies (can be overridden per policy)"
  type        = bool
  default     = false
}

variable "security_policies" {
  description = "Map of security policies to create, each with its own configuration"
  type = map(object({
    endpoints           = list(string)
    rate_limit_count    = number
    rate_limit_interval = number
    preview_mode        = optional(bool)
  }))
  default = {}
}