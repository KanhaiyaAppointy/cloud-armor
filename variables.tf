variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The Google Cloud region"
  type        = string
  default     = "us-central1"
}

variable "security_policy_name" {
  description = "Name of the Cloud Armor security policy"
  type        = string
  default     = "endpoint-throttling-policy"
}

variable "backend_service_name" {
  description = "Name of the existing ALB backend service to attach the policy to"
  type        = string
}

variable "preview_mode" {
  description = "Whether to enable preview mode for the security policy rules (test without enforcing)"
  type        = bool
  default     = true
}

variable "endpoints" {
  description = "List of endpoint paths to apply throttling to"
  type        = list(string)
  default = [
    "/api/endpoint1",
    "/api/endpoint2",
    "/api/endpoint3",
    "/api/endpoint4",
    "/api/endpoint5"
  ]
}

variable "rate_limit_count" {
  description = "Number of requests allowed within the interval"
  type        = number
  default     = 100
}

variable "rate_limit_interval_sec" {
  description = "Time interval in seconds for the rate limit"
  type        = number
  default     = 10
}