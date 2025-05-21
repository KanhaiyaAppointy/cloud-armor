output "security_policy_id" {
  description = "The ID of the created Cloud Armor security policy"
  value       = google_compute_security_policy.endpoint_throttling_policy.id
}

output "security_policy_self_link" {
  description = "The self link of the created Cloud Armor security policy"
  value       = google_compute_security_policy.endpoint_throttling_policy.self_link
}

output "security_policy_fingerprint" {
  description = "The fingerprint of the Cloud Armor security policy"
  value       = google_compute_security_policy.endpoint_throttling_policy.fingerprint
}

output "backend_service_attachment" {
  description = "The name of the backend service with the attached security policy"
  value       = var.backend_service_name
}