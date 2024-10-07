output "datadog_service_account_email" {
  value = google_service_account_email.datadog_integration.email
}