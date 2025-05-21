variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "default_preview_mode" {
  description = "Global default preview mode (can be overridden per policy)"
  type        = bool
  default     = false
}

variable "security_policies" {
  description = "A map of security policies and their configurations"
  type = map(object({
    endpoints           = list(string)
    rate_limit_count    = number
    rate_limit_interval = number
    preview_mode        = optional(bool)
  }))
}