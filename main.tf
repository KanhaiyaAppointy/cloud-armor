provider "google" {
  project = var.project_id
  region  = var.region
}

module "throttling_security_policy" {
  source = "./modules/security_policy"

  project_id           = var.project_id
  region               = var.region
  security_policy_name = var.security_policy_name
  backend_service_name = var.backend_service_name
  endpoints            = var.endpoints
  rate_limit_count     = var.rate_limit_count
  rate_limit_interval  = var.rate_limit_interval
  preview_mode         = var.preview_mode
}