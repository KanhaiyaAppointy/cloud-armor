# Required values - replace with your specific values
project_id           = "your-gcp-project-id"
backend_service_name = "your-alb-backend-service-name"

# Optional values with defaults
region               = "us-central1"
security_policy_name = "endpoint-throttling-policy"

# The specific endpoints to throttle
endpoints = [
  "/api/endpoint1",
  "/api/endpoint2",
  "/api/endpoint3",
  "/api/endpoint4",
  "/api/endpoint5"
]

# Rate limiting configuration: 100 requests per 10 seconds
rate_limit_count    = 100
rate_limit_interval = 10

# Set to false to enforce in production
preview_mode        = true