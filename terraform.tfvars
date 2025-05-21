# Required values
project_id = "your-gcp-project-id"
region     = "us-central1"

# Default preview mode for all policies (can be overridden per policy)
default_preview_mode = true

# Multiple security policies configuration
security_policies = {
  "api-throttling-policy" = {
    endpoints = [
      "/api/endpoint1",
      "/api/endpoint2",
      "/api/endpoint3"
    ],
    rate_limit_count    = 100,
    rate_limit_interval = 10,
    preview_mode        = true
  },

  "admin-throttling-policy" = {
    endpoints = [
      "/admin/users",
      "/admin/settings"
    ],
    rate_limit_count    = 50, # Lower limit for admin endpoints
    rate_limit_interval = 60, # Over a longer period
    preview_mode        = true
  },

  "public-throttling-policy" = {
    endpoints = [
      "/public/resources",
      "/public/search"
    ],
    rate_limit_count    = 200, # Higher limit for public endpoints
    rate_limit_interval = 5
  }
}