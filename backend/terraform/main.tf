provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_cloud_run_service" "default" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.container_image
        resources {
          limits = {
            memory = "256Mi"
            cpu    = "1000m"
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "invoker" {
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  service     = google_cloud_run_service.default.name
  role        = "roles/run.invoker"
  member      = "allUsers" 
}

variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "region" {
  description = "The region in which to create the Cloud Run service."
  type        = string
  default     = "us-central1"
}

variable "service_name" {
  description = "The name of the Cloud Run service."
  type        = string
  default     = "backend"
}

variable "container_image" {
  description = "The URL of the container image in a container registry."
  type        = string
  default     = "us-central1-docker.pkg.dev/mytest-425707/backend/backend:latest"
}

variable "credentials_file" {
  description = "The path to the service account key file."
  type        = string
  default     = "~/terraform-key.json"
}
