variable "project_id" {
  description = "GCP Project Id"
  type        = string
}

variable "github_org" {
  description = "Github Organization"
  type        = string
  default     = "brandlive1941"
}

variable "terraform_repo_name" {
  description = "Repository Name"
  type        = string
  default     = "terraform-gcp"
}

variable "api_key" {
  description = "Datadog API Key"
  type        = string
}

variable "app_key" {
  description = "Datadog APP Key"
  type        = string
}

variable "site" {
  description = "Datadog Site"
  type        = string
  default     = "datadoghq.com"
}