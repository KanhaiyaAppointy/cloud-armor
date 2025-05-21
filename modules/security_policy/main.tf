resource "google_compute_security_policy" "endpoint_throttling_policy" {
  name        = var.security_policy_name
  description = "Security policy for endpoint throttling"
  project     = var.project_id

  # Default rule (required) - allow all traffic that doesn't match other rules
  rule {
    action   = "allow"
    priority = 2147483647
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Default rule, higher priority overrides it"
  }

  # For each endpoint in the endpoints list, create a rate limiting rule
  dynamic "rule" {
    for_each = { for idx, endpoint in var.endpoints : idx => endpoint }
    
    content {
      action      = "throttle"
      priority    = 1000 + rule.key
      description = "Rate limit for ${rule.value}"
      
      match {
        expr {
          expression = "request.path.matches('${rule.value}')"
        }
      }
      
      rate_limit_options {
        conform_action      = "allow"
        exceed_action       = "deny(429)"
        enforce_on_key      = "IP"
        rate_limit_threshold {
          count        = var.rate_limit_count
          interval_sec = var.rate_limit_interval
        }
      }
    }
  }
}