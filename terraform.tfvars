project_id           = "your-projct-id"
region               = "us-central1"
default_preview_mode = true

security_policies = {
  api-throttle = {
    endpoints           = ["/index.html", "/index1.html", "/index2.html"]
    rate_limit_count    = 100
    rate_limit_interval = 10
    preview_mode        = true
  }

  api2-throttle = {
    endpoints           = ["/index3.html"]
    rate_limit_count    = 50
    rate_limit_interval = 60
  }

  api3-throttle = {
    endpoints           = ["/index4.html"]
    rate_limit_count    = 200
    rate_limit_interval = 30
  }
}