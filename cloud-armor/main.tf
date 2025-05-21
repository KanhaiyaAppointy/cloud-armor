provider "google" {
  project = var.project_id
  region  = var.region
}

locals {
  # Build the expression for matching any of the specified endpoints
  endpoint_expression = join(" || ", [
    for endpoint in var.endpoints :
    "request.path.matches('${endpoint}')"
  ])
}

# Create a new Cloud Armor security policy
resource "google_compute_security_policy" "endpoint_throttling_policy" {
  name        = var.security_policy_name
  description = "Security policy to throttle specific endpoints for IP 11.11.11.11 only"

  # Rule to throttle the specific IP (11.11.11.11) on all endpoints
  rule {
    action      = "throttle"
    priority    = 1000
    description = "Rate limit requests from exactly IP 11.11.11.11 to the specified endpoints"
    preview     = var.preview_mode # Set to false for production deployment

    match {
      expr {
        # Match requests where:
        # 1. The IP is exactly 11.11.11.11 (no range, just one IP)
        # 2. The request path is one of the specified endpoints (dynamically generated)
        expression = "origin.ip == '11.11.11.11' && (${local.endpoint_expression})"
      }
    }

    rate_limit_options {
      conform_action = "allow"
      exceed_action  = "deny(429)" # Return HTTP 429 Too Many Requests
      enforce_on_key = "ALL"       # Since we're already filtering by exact IP in the match condition
      rate_limit_threshold {
        count        = var.rate_limit_count
        interval_sec = var.rate_limit_interval_sec
      }
    }
  }

  # Default rule (always evaluated last)
  rule {
    action   = "allow"
    priority = "2147483647" # Maximum priority, always evaluated last
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"] # Match all IPs
      }
    }
    description = "Default rule, matches all traffic"
  }
}

# Attach the security policy to the existing backend service (ALB)
#resource "google_compute_backend_service_security_policy_attachment" "attachment" {
#  provider        = google-beta
#  security_policy = google_compute_security_policy.endpoint_throttling_policy.id
#  backend_service = var.backend_service_name
#}
