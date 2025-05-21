resource "google_compute_security_policy" "endpoint_throttling_policy" {
  name        = var.security_policy_name
  description = "Cloud Armor policy for endpoint throttling"
  project     = var.project_id

  dynamic "rule" {
    for_each = { for idx, ep in var.endpoints : idx => ep }

    content {
      action   = "throttle"
      priority = 1000 + rule.key

      match {
        expr {
          expression = "request.path.matches(\"${rule.value}\")"
        }
      }

      rate_limit_options {
        conform_action = "allow"
        exceed_action  = "deny(429)"
        enforce_on_key = "IP"

        rate_limit_threshold {
          count        = var.rate_limit_count
          interval_sec = var.rate_limit_interval
        }
      }

      preview     = var.preview_mode
      description = "Rate limit rule for ${rule.value}"
    }
  }

  # Default catch-all allow rule
  rule {
    action   = "allow"
    priority = 2147483647
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Default allow rule"
  }
}
