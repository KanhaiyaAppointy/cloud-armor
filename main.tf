provider "google" {
  project = var.project_id
  region  = var.region
}

# Create multiple security policies based on the security_policies variable
module "security_policies" {
  source   = "./modules/security_policy"
  for_each = var.security_policies

  project_id           = var.project_id
  region               = var.region
  security_policy_name = each.key
  endpoints            = each.value.endpoints
  rate_limit_count     = each.value.rate_limit_count
  rate_limit_interval  = each.value.rate_limit_interval
  preview_mode         = lookup(each.value, "preview_mode", var.default_preview_mode)
}