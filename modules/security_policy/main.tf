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
  description = "Security policy to throttle specific endpoints for all IPs"
  project     = var.project_id

  # Rule to throttle specific endpoints for all IPs
  rule {
    action      = "throttle"
    priority    = 1000
    description = "Rate limit requests to the specified endpoints from any IP"
    preview     = var.preview_mode

    match {
      expr {
        # Match requests where the path is one of the specified endpoints
        expression = local.endpoint_expression
      }
    }

    rate_limit_options {
      conform_action = "allow"
      exceed_action  = "deny(429)" # Return HTTP 429 Too Many Requests
      enforce_on_key = "IP"        # Apply rate limiting per source IP
      
      rate_limit_threshold {
        count        = var.rate_limit_count
        interval_sec = var.rate_limit_interval
      }
    }
  }

  # Default rule (always evaluated last) - allow all other traffic
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
  #security_policy = google_compute_security_policy.endpoint_throttling_policy.id
  #backend_service = var.backend_service_name
 # project         = var.project_id
#}