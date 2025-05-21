output "security_policy_self_link" {
  description = "Self-link of the security policy"
  value       = google_compute_security_policy.endpoint_throttling_policy.self_link
}