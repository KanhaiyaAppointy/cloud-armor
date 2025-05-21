# Replace with your specific values
project_id           = "your-project-id"
region               = "us-central1"
security_policy_name = "endpoint-throttling-policy"
backend_service_name = "your-alb-backend-service-name"

# Set to false when ready to enforce the policy
preview_mode = true

# Specific endpoints to throttle
endpoints = [
  "/api/endpoint1",
  "/api/endpoint2",
  "/api/endpoint3",
  "/api/endpoint4",
  "/api/endpoint5"
]

# Rate limiting configuration: 100 requests per 10 seconds
rate_limit_count        = 100
rate_limit_interval_sec = 10