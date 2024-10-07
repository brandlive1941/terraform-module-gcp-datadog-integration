terraform {
  required_version = ">= 1.5.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.70.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.70.0"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = ">= 3.35.0"
    }
  }
}

locals {
  roles = [
    "roles/monitoring.viewer",
    "roles/compute.viewer",
    "roles/cloudasset.viewer",
    "roles/browser"
  ]
}

# Configure the Datadog provider
provider "datadog" {
  api_key = var.api_key
  app_key = var.app_key
}

// Service account should have compute.viewer, monitoring.viewer, and cloudasset.viewer roles.
resource "google_service_account" "datadog_integration" {
  account_id   = "datadogintegration"
  display_name = "Datadog Integration"
  project      = var.project_id
}

// Grant token creator role to the Datadog principal account.
resource "google_service_account_iam_member" "datadog_sa_iam" {
  service_account_id = google_service_account.datadog_integration.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${google_service_account.datadog_integration.email}"
}

// Grant roles to the Datadog principal account.
resource "google_project_iam_member" "datadog_user" {
  for_each = toset(local.roles)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.datadog_integration.email}"
}

resource "datadog_integration_gcp_sts" "datadog" {
  client_email    = google_service_account.datadog_integration.email
  automute        = true
  is_cspm_enabled = true
}


resource "google_pubsub_topic" "export_logs_to_datadog" {
  name = "export-logs-to-datadog"
}

resource "google_pubsub_subscription" "datadog_logs" {
  name  = "datadog-logs"
  topic = google_pubsub_topic.export_logs_to_datadog.name

  message_retention_duration = "604800s"
  retain_acked_messages      = false
  ack_deadline_seconds       = 60

  push_config {
    push_endpoint = "https://gcp-intake.logs.${var.site}/v1/input/${var.api_key}/"
  }
}

resource "google_logging_project_sink" "datadog_sink" {
  name                   = "datadog-sink"
  destination            = "pubsub.googleapis.com/${google_pubsub_topic.export_logs_to_datadog.id}"
  filter                 = ""
  unique_writer_identity = true
}

resource "google_project_iam_member" "pubsub_publisher_permisson" {
  project = var.project_id
  role    = "roles/pubsub.publisher"
  member  = google_logging_project_sink.datadog_sink.writer_identity
}